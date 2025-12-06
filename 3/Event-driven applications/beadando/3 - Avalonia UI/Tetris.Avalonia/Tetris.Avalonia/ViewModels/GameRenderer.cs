using System;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media;
using System.Windows.Shapes;
using Tetris.Model;

namespace Tetris.ViewModel
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
            if (!Application.Current.Dispatcher.CheckAccess())
            {
                Application.Current.Dispatcher.BeginInvoke(new Action(() => DrawGame(canvas, model)));
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
                    X1 = col * CellSize,
                    Y1 = 0,
                    X2 = col * CellSize,
                    Y2 = model.Rows * CellSize,
                    Stroke = gridBrush,
                    StrokeThickness = 1
                };
                canvas.Children.Add(line);
            }

            for (int row = 0; row <= model.Rows; row++)
            {
                Line line = new Line
                {
                    X1 = 0,
                    Y1 = row * CellSize,
                    X2 = model.Cols * CellSize,
                    Y2 = row * CellSize,
                    Stroke = gridBrush,
                    StrokeThickness = 1
                };
                canvas.Children.Add(line);
            }
        }

        /// <summary>
        /// Canvas és border méretének frissítése.
        /// </summary>
        public static void UpdateCanvasSize(Canvas canvas, FrameworkElement border, int cols, int rows)
        {
            double canvasWidth = cols * CellSize;
            double canvasHeight = rows * CellSize;
            
            canvas.Width = canvasWidth;
            canvas.Height = canvasHeight;
            
            border.Width = canvasWidth;
            border.Height = canvasHeight;
        }

        /// <summary>
        /// System.Drawing.Color konvertálása System.Windows.Media.Color-ra.
        /// </summary>
        private static System.Windows.Media.Color ConvertColor(System.Drawing.Color color)
        {
            return System.Windows.Media.Color.FromArgb(color.A, color.R, color.G, color.B);
        }
    }
}
