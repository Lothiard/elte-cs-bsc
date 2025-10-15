using System.Windows;
using System.Windows.Media;

namespace ELTE.SmileyTransformations
{
    public partial class MainWindow : Window
    {
        private TransformGroup _transformGroup; // transzformációs csoport
        private SkewTransform _transformSkew; // nyújtás
        private RotateTransform _transformRotate; // forgatás
        private TranslateTransform _transformTranslate; // mozgatás
        private ScaleTransform _transformScale; // nagyítás

        public MainWindow()
        {
            InitializeComponent();

            _transformSkew = new SkewTransform(0, 0); // kezdeti értékek megadása
            _transformRotate = new RotateTransform(0);
            _transformTranslate = new TranslateTransform(0, 0);
            _transformScale = new ScaleTransform(1, 1);

            _transformGroup = new TransformGroup();
            _transformGroup.Children.Add(_transformSkew); // felvesszük a transzformációs csoport elemeit
            _transformGroup.Children.Add(_transformRotate);
            _transformGroup.Children.Add(_transformTranslate);
            _transformGroup.Children.Add(_transformScale);

            _rectangleSmiley.RenderTransform = _transformGroup; // transzformációk megadása
            _sliderScaleX.Value = 1;
            _sliderScaleY.Value = 1;
        }

        private void Slider_ValueChanged(object sender, RoutedEventArgs e)
        {
            _transformRotate.Angle = _sliderRotateAngle.Value; // transzformációk értékeinek megadása
            _transformRotate.CenterX = _sliderRotatePointX.Value;
            _transformRotate.CenterY = _sliderRotatePointY.Value;

            _transformScale.ScaleX = _sliderScaleX.Value;
            _transformScale.ScaleY = _sliderScaleY.Value;
            _transformScale.CenterX = _sliderScalePointX.Value;
            _transformScale.CenterY = _sliderScalePointY.Value;

            _transformSkew.AngleX = _sliderSkewX.Value;
            _transformSkew.AngleY = _sliderSkewY.Value;
            _transformSkew.CenterX = _sliderSkewPointX.Value;
            _transformSkew.CenterY = _sliderSkewPointY.Value;

            _transformTranslate.X = _sliderTranslateX.Value;
            _transformTranslate.Y = _sliderTranslateY.Value;
        }

        private void ButtonDefault_Click(object sender, RoutedEventArgs e)
        {
            _sliderRotateAngle.Value = _sliderRotatePointX.Value = _sliderRotatePointY.Value = 0;
            _sliderTranslateX.Value = _sliderTranslateY.Value = _sliderScalePointX.Value = _sliderScalePointY.Value = 0;
            _sliderSkewX.Value = _sliderSkewY.Value = _sliderSkewPointX.Value = _sliderSkewPointY.Value = 0;
            _sliderScaleX.Value = _sliderScaleY.Value = 1;
        }
    }
}
