using Android.App;
using Android.Content.PM;

using Avalonia;
using Avalonia.Android;

namespace ELTE.Sudoku.Avalonia.Android;

[Activity(
    Label = "Sudoku Game",
    Theme = "@style/MyTheme.NoActionBar",
    Icon = "@drawable/sudoku",
    MainLauncher = true,
    ConfigurationChanges = ConfigChanges.Orientation | ConfigChanges.ScreenSize | ConfigChanges.UiMode)]
public class MainActivity : AvaloniaMainActivity<App>
{
    protected override AppBuilder CustomizeAppBuilder(AppBuilder builder)
    {
        return base.CustomizeAppBuilder(builder)
            .WithInterFont();
    }
}
