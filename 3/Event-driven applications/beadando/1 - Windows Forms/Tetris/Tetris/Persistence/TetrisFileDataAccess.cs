using System;
using System.IO;
using System.Text.Json;
using System.Threading.Tasks;

namespace Tetris.Persistence
{
    public class TetrisFileDataAccess : ITetrisDataAccess
    {
        public async Task SaveAsync(string filePath, TetrisPersistence.GameState state)
        {
            try
            {
                using (StreamWriter writer = new StreamWriter(filePath))
                {
                    await writer.WriteLineAsync($"{state.Rows} {state.Cols}");
                    
                    await writer.WriteLineAsync($"{state.CurrentTetrominoIndex} {state.BlockRow} {state.BlockCol}");
                    
                    await writer.WriteAsync($"{state.CurrentBlock.Length}");
                    for (int i = 0; i < state.CurrentBlock.Length; i++)
                    {
                        await writer.WriteAsync($" {state.CurrentBlock[i].row} {state.CurrentBlock[i].col}");
                    }
                    await writer.WriteLineAsync();
                    
                    await writer.WriteLineAsync(state.PausedTime.TotalSeconds.ToString());
                    
                    await writer.WriteLineAsync(state.SaveTime.ToString("o"));
                    
                    for (int i = 0; i < state.Rows; i++)
                    {
                        for (int j = 0; j < state.Cols; j++)
                        {
                            await writer.WriteAsync($"{state.Board[i, j]} ");
                        }
                        await writer.WriteLineAsync();
                    }
                }
            }
            catch (Exception ex)
            {
                throw new TetrisDataException("Error saving game state.", ex);
            }
        }

        public async Task<TetrisPersistence.GameState?> LoadAsync(string filePath)
        {
            try
            {
                using (StreamReader reader = new StreamReader(filePath))
                {
                    string? line = await reader.ReadLineAsync();
                    if (string.IsNullOrEmpty(line))
                        throw new TetrisDataException("Invalid save file: missing dimensions.");
                        
                    string[] dimensions = line.Split(' ', StringSplitOptions.RemoveEmptyEntries);
                    if (dimensions.Length < 2)
                        throw new TetrisDataException("Invalid save file format: missing dimensions.");
                        
                    int rows = int.Parse(dimensions[0]);
                    int cols = int.Parse(dimensions[1]);
                    
                    if (rows <= 0 || cols <= 0)
                        throw new TetrisDataException("Invalid dimensions in save file.");
                    
                    TetrisPersistence.GameState state = new TetrisPersistence.GameState
                    {
                        Rows = rows,
                        Cols = cols,
                        Board = new int[rows, cols]
                    };
                    
                    line = await reader.ReadLineAsync();
                    if (string.IsNullOrEmpty(line))
                        throw new TetrisDataException("Invalid save file: missing tetromino info.");
                        
                    string[] tetrominoInfo = line.Split(' ', StringSplitOptions.RemoveEmptyEntries);
                    if (tetrominoInfo.Length < 3)
                        throw new TetrisDataException("Invalid save file format: missing tetromino information.");
                        
                    state.CurrentTetrominoIndex = int.Parse(tetrominoInfo[0]);
                    state.BlockRow = int.Parse(tetrominoInfo[1]);
                    state.BlockCol = int.Parse(tetrominoInfo[2]);
                    
                    line = await reader.ReadLineAsync();
                    if (string.IsNullOrEmpty(line))
                        throw new TetrisDataException("Invalid save file: missing block positions.");
                        
                    string[] blockInfo = line.Split(' ', StringSplitOptions.RemoveEmptyEntries);
                    if (blockInfo.Length < 1)
                        throw new TetrisDataException("Invalid save file format: missing block information.");
                        
                    int blockCount = int.Parse(blockInfo[0]);
                    
                    if (blockInfo.Length < 1 + blockCount * 2)
                        throw new TetrisDataException("Invalid save file format: incomplete block data.");
                        
                    state.CurrentBlock = new (int row, int col)[blockCount];
                    
                    for (int i = 0; i < blockCount; i++)
                    {
                        int rowIndex = 1 + i * 2;
                        int colIndex = 2 + i * 2;
                        
                        if (rowIndex < blockInfo.Length && colIndex < blockInfo.Length)
                        {
                            state.CurrentBlock[i] = (
                                int.Parse(blockInfo[rowIndex]),
                                int.Parse(blockInfo[colIndex])
                            );
                        }
                    }
                    
                    line = await reader.ReadLineAsync();
                    if (string.IsNullOrEmpty(line))
                        throw new TetrisDataException("Invalid save file: missing paused time.");
                    
                    if (double.TryParse(line, out double pausedSeconds))
                    {
                        state.PausedTime = TimeSpan.FromSeconds(pausedSeconds);
                    }
                    else
                    {
                        state.PausedTime = TimeSpan.Zero;
                    }
                    
                    line = await reader.ReadLineAsync();
                    if (string.IsNullOrEmpty(line))
                        throw new TetrisDataException("Invalid save file: missing save time.");
                    
                    if (DateTime.TryParse(line, out DateTime saveTime))
                    {
                        state.SaveTime = saveTime;
                    }
                    else
                    {
                        state.SaveTime = DateTime.Now;
                    }
                    
                    for (int i = 0; i < rows; i++)
                    {
                        line = await reader.ReadLineAsync();
                        if (string.IsNullOrEmpty(line))
                            throw new TetrisDataException($"Invalid save file: missing board row {i}.");
                            
                        string[] values = line.Split(' ', StringSplitOptions.RemoveEmptyEntries);
                        
                        if (values.Length < cols)
                            throw new TetrisDataException($"Invalid board data: row {i} has insufficient columns.");
                        
                        for (int j = 0; j < cols; j++)
                        {
                            state.Board[i, j] = int.Parse(values[j]);
                        }
                    }
                    
                    return state;
                }
            }
            catch (Exception ex)
            {
                throw new TetrisDataException("Error loading game state: " + ex.Message, ex);
            }
        }
    }
}