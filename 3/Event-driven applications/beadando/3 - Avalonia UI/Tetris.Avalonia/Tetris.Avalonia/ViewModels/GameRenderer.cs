using System;
using Avalonia;
using Avalonia.Controls;
using Avalonia.Controls.Shapes;
using Avalonia.Media;
using Avalonia.Threading;
using Tetris.Model;

namespace Tetris.Avalonia.ViewModels
{
    /// <summary>
    /// Játék renderelési segédosztály.
    /// </summary>
    public static class GameRenderer
    {
        private const int CellSize = 30;

        /// <summary>
        /// Játéktábla kirajzolása.
        /// </summary>
        /// <param name="canvas">A rajzolási felület.</param>
        /// <param name="model">A játékmodell.</param>
        public static void DrawGame(Canvas canvas, TetrisGameModel model)
        {
            if (!Dispatcher.UIThread.CheckAccess())
            {
                Dispatcher.UIThread.InvokeAsync(() => DrawGame(canvas, model));
                return;
            }

            canvas.Children.Clear();

            DrawGrid(canvas, model);

            for (int row = 0; row < model.Rows; row++)
            {
                for (int col = 0; col < model.Cols; col++)
                {
                    if (model.Board[row, col] != 0)
                    {
                        Rectangle rect = new Rectangle
                        {
                            Width = CellSize,
                            Height = CellSize,
                            Fill = new SolidColorBrush(ConvertColor(model.TetrominoColors[model.Board[row, col] - 1])),
                            Stroke = Brushes.Black,
                            StrokeThickness = 1
                        };

                        Canvas.SetLeft(rect, col * CellSize);
                        Canvas.SetTop(rect, row * CellSize);
                        canvas.Children.Add(rect);
                    }
                }
            }

            if (model.CurrentBlock != null && !model.IsGameOver)
            {
                System.Drawing.Color tetrominoColor = model.TetrominoColors[model.CurrentTetrominoIndex];
                
                foreach (var (dr, dc) in model.CurrentBlock)
                {
                    int row = model.BlockRow + dr;
                    int col = model.BlockCol + dc;

                    if (row >= 0 && row < model.Rows && col >= 0 && col < model.Cols)
                    {
                        Rectangle rect = new Rectangle
                        {
                            Width = CellSize,
                            Height = CellSize,
                            Fill = new SolidColorBrush(ConvertColor(tetrominoColor)),
                            Stroke = Brushes.Black,
                            StrokeThickness = 1
                        };

                        Canvas.SetLeft(rect, col * CellSize);
                        Canvas.SetTop(rect, row * CellSize);
                        canvas.Children.Add(rect);
                    }
                }
            }
        }

        /// <summary>
        /// Háttérrács kirajzolása.
        /// </summary>
        private static void DrawGrid(Canvas canvas, TetrisGameModel model)
        {
            var gridBrush = new SolidColorBrush(Color.FromRgb(220, 220, 220));
            
            for (int col = 0; col <= model.Cols; col++)
            {
                Line line = new Line
                {
                    StartPoint = new Point(col * CellSize, 0),
                    EndPoint = new Point(col * CellSize, model.Rows * CellSize),
                    Stroke = gridBrush,
                    StrokeThickness = 1
                };
                canvas.Children.Add(line);
            }

            for (int row = 0; row <= model.Rows; row++)
            {
                Line line = new Line
                {
                    StartPoint = new Point(0, row * CellSize),
                    EndPoint = new Point(model.Cols * CellSize, row * CellSize),
                    Stroke = gridBrush,
                    StrokeThickness = 1
                };
                canvas.Children.Add(line);
            }
        }

        /// <summary>
        /// Canvas és border méretének frissítése.
        /// </summary>
        public static void UpdateCanvasSize(Canvas canvas, Control border, int cols, int rows)
        {
            double canvasWidth = cols * CellSize;
            double canvasHeight = rows * CellSize;
            
            canvas.Width = canvasWidth;
            canvas.Height = canvasHeight;
            
            border.Width = canvasWidth;
            border.Height = canvasHeight;
        }

        /// <summary>
        /// System.Drawing.Color konvertálása Avalonia.Media.Color-ra.
        /// </summary>
        private static Color ConvertColor(System.Drawing.Color color)
        {
            return Color.FromArgb(color.A, color.R, color.G, color.B);
        }
    }
}
