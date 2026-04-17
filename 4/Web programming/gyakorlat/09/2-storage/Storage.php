<?php

interface IFileIO
{
    public function save($data);
    public function load();
}
abstract class FileIO implements IFileIO
{
    protected $filepath;

    public function __construct($filename)
    {
        if (!is_readable($filename) || !is_writable($filename)) {
            throw new Exception("Data source {$filename} is invalid.");
        }
        $this->filepath = realpath($filename);
    }
}
class JsonIO extends FileIO
{
    public function load($assoc = true)
    {
        $file_content = file_get_contents($this->filepath);
        return json_decode($file_content, $assoc) ?: [];
    }

    public function save($data)
    {
        $json_content = json_encode($data, JSON_PRETTY_PRINT);
        file_put_contents($this->filepath, $json_content);
    }
}
class SerializeIO extends FileIO
{
    public function load()
    {
        $file_content = file_get_contents($this->filepath);
        return unserialize($file_content) ?: [];
    }

    public function save($data)
    {
        $serialized_content = serialize($data);
        file_put_contents($this->filepath, $serialized_content);
    }
}

interface IStorage
{
    public function add($record): string;
    public function findById(string $id);
    public function findAll(array $params = []);
    public function findOne(array $params = []);
    public function update(string $id, $record);
    public function delete(string $id);

    public function findMany(callable $condition);
    public function updateMany(callable $condition, callable $updater);
    public function deleteMany(callable $condition);
}

class Storage implements IStorage
{
    protected $contents;
    protected $io;

    public function __construct(IFileIO $io, $assoc = true)
    {
        $this->io = $io;
        $this->contents = (array)$this->io->load($assoc);
    }

    public function __destruct()
    {
        $this->io->save($this->contents);
    }

    public function add($record): string
    {
        $id = uniqid();
        if (is_array($record)) {
            $record['id'] = $id;
        } elseif (is_object($record)) {
            $record->id = $id;
        }
        $this->contents[$id] = $record;
        return $id;
    }

    public function findById(string $id)
    {
        return $this->contents[$id] ?? null;
    }

    public function findAll(array $params = [])
    {
        return array_filter($this->contents, function ($item) use ($params) {
            foreach ($params as $key => $value) {
                if (((array)$item)[$key] !== $value) {
                    return false;
                }
            }
            return true;
        });
    }

    public function findOne(array $params = [])
    {
        $found_items = $this->findAll($params);
        $first_index = array_keys($found_items)[0] ?? null;
        return $found_items[$first_index] ?? null;
    }

    public function update(string $id, $record)
    {
        $this->contents[$id] = $record;
    }

    public function delete(string $id)
    {
        unset($this->contents[$id]);
    }

    public function findMany(callable $condition)
    {
        return array_filter($this->contents, $condition);
    }

    public function updateMany(callable $condition, callable $updater)
    {
        array_walk($this->contents, function (&$item) use ($condition, $updater) {
            if ($condition($item)) {
                $updater($item);
            }
        });
    }

    public function deleteMany(callable $condition)
    {
        $this->contents = array_filter($this->contents, function ($item) use ($condition) {
            return !$condition($item);
        });
    }
}
