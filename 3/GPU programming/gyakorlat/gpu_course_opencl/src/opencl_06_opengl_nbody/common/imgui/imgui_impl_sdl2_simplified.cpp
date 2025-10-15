#include "imgui_impl_sdl2.h"
#include "imgui.h"

// SDL
#include <SDL2/SDL.h>

// Data
struct ImGui_ImplSDL2_Data
{
    SDL_Window*     Window;
    SDL_Renderer*   Renderer;
    Uint64          Time;
    bool            MousePressed[3];
    SDL_Cursor*     MouseCursors[ImGuiMouseCursor_COUNT];
    int             MouseButtonsDown;
    SDL_GLContext   GLContext;

    ImGui_ImplSDL2_Data() { memset(this, 0, sizeof(*this)); }
};

// Backend data stored in io.BackendPlatformUserData to allow support for multiple Dear ImGui contexts
static ImGui_ImplSDL2_Data* ImGui_ImplSDL2_GetBackendData()
{
    return ImGui::GetCurrentContext() ? (ImGui_ImplSDL2_Data*)ImGui::GetIO().BackendPlatformUserData : NULL;
}

// Functions
static const char* ImGui_ImplSDL2_GetClipboardText(void*)
{
    ImGui_ImplSDL2_Data* bd = ImGui_ImplSDL2_GetBackendData();
    if (bd->Window == NULL)
        return NULL;
    
    static char* buf = NULL;
    if (buf)
        SDL_free(buf);
    buf = SDL_GetClipboardText();
    return buf;
}

static void ImGui_ImplSDL2_SetClipboardText(void*, const char* text)
{
    ImGui_ImplSDL2_Data* bd = ImGui_ImplSDL2_GetBackendData();
    if (bd->Window == NULL)
        return;
    
    SDL_SetClipboardText(text);
}

bool ImGui_ImplSDL2_ProcessEvent(const SDL_Event* event)
{
    ImGuiIO& io = ImGui::GetIO();
    ImGui_ImplSDL2_Data* bd = ImGui_ImplSDL2_GetBackendData();

    switch (event->type)
    {
    case SDL_MOUSEWHEEL:
        {
            if (event->wheel.x > 0) io.AddMouseWheelEvent(1.0f, 0.0f);
            if (event->wheel.x < 0) io.AddMouseWheelEvent(-1.0f, 0.0f);
            if (event->wheel.y > 0) io.AddMouseWheelEvent(0.0f, 1.0f);
            if (event->wheel.y < 0) io.AddMouseWheelEvent(0.0f, -1.0f);
            return true;
        }
    case SDL_MOUSEBUTTONDOWN:
        {
            if (event->button.button == SDL_BUTTON_LEFT) { bd->MousePressed[0] = true; }
            if (event->button.button == SDL_BUTTON_RIGHT) { bd->MousePressed[1] = true; }
            if (event->button.button == SDL_BUTTON_MIDDLE) { bd->MousePressed[2] = true; }
            bd->MouseButtonsDown |= 1 << event->button.button;
            return true;
        }
    case SDL_MOUSEBUTTONUP:
        {
            if (event->button.button == SDL_BUTTON_LEFT) { bd->MousePressed[0] = false; }
            if (event->button.button == SDL_BUTTON_RIGHT) { bd->MousePressed[1] = false; }
            if (event->button.button == SDL_BUTTON_MIDDLE) { bd->MousePressed[2] = false; }
            bd->MouseButtonsDown &= ~(1 << event->button.button);
            return true;
        }
    case SDL_TEXTINPUT:
        {
            io.AddInputCharactersUTF8(event->text.text);
            return true;
        }
    case SDL_KEYDOWN:
    case SDL_KEYUP:
        {
            int key = event->key.keysym.sym & ~SDLK_SCANCODE_MASK;
            io.AddKeyEvent(ImGuiKey_Tab, key == SDLK_TAB);
            io.AddKeyEvent(ImGuiKey_LeftArrow, key == SDLK_LEFT);
            io.AddKeyEvent(ImGuiKey_RightArrow, key == SDLK_RIGHT);
            io.AddKeyEvent(ImGuiKey_UpArrow, key == SDLK_UP);
            io.AddKeyEvent(ImGuiKey_DownArrow, key == SDLK_DOWN);
            io.AddKeyEvent(ImGuiKey_PageUp, key == SDLK_PAGEUP);
            io.AddKeyEvent(ImGuiKey_PageDown, key == SDLK_PAGEDOWN);
            io.AddKeyEvent(ImGuiKey_Home, key == SDLK_HOME);
            io.AddKeyEvent(ImGuiKey_End, key == SDLK_END);
            io.AddKeyEvent(ImGuiKey_Insert, key == SDLK_INSERT);
            io.AddKeyEvent(ImGuiKey_Delete, key == SDLK_DELETE);
            io.AddKeyEvent(ImGuiKey_Backspace, key == SDLK_BACKSPACE);
            io.AddKeyEvent(ImGuiKey_Space, key == SDLK_SPACE);
            io.AddKeyEvent(ImGuiKey_Enter, key == SDLK_RETURN);
            io.AddKeyEvent(ImGuiKey_Escape, key == SDLK_ESCAPE);
            io.AddKeyEvent(ImGuiKey_KeypadEnter, key == SDLK_KP_ENTER);

            io.AddKeyEvent(ImGuiMod_Ctrl, (event->key.keysym.mod & KMOD_CTRL) != 0);
            io.AddKeyEvent(ImGuiMod_Shift, (event->key.keysym.mod & KMOD_SHIFT) != 0);
            io.AddKeyEvent(ImGuiMod_Alt, (event->key.keysym.mod & KMOD_ALT) != 0);
            io.AddKeyEvent(ImGuiMod_Super, (event->key.keysym.mod & KMOD_GUI) != 0);

            return true;
        }
    case SDL_WINDOWEVENT:
        {
            if (event->window.event == SDL_WINDOWEVENT_FOCUS_GAINED)
                io.AddFocusEvent(true);
            else if (event->window.event == SDL_WINDOWEVENT_FOCUS_LOST)
                io.AddFocusEvent(false);
            return true;
        }
    }
    return false;
}

static void ImGui_ImplSDL2_UpdateMouseData()
{
    ImGuiIO& io = ImGui::GetIO();
    ImGui_ImplSDL2_Data* bd = ImGui_ImplSDL2_GetBackendData();

    // Set mouse position
    if (io.WantSetMousePos)
        SDL_WarpMouseInWindow(bd->Window, (int)io.MousePos.x, (int)io.MousePos.y);
    else
    {
        int mx, my;
        Uint32 mouse_buttons = SDL_GetMouseState(&mx, &my);
        io.AddMousePosEvent((float)mx, (float)my);

        // Set mouse buttons
        io.AddMouseButtonEvent(0, (mouse_buttons & SDL_BUTTON(SDL_BUTTON_LEFT)) != 0);
        io.AddMouseButtonEvent(1, (mouse_buttons & SDL_BUTTON(SDL_BUTTON_RIGHT)) != 0);
        io.AddMouseButtonEvent(2, (mouse_buttons & SDL_BUTTON(SDL_BUTTON_MIDDLE)) != 0);
    }
}

static void ImGui_ImplSDL2_UpdateMouseCursor()
{
    ImGuiIO& io = ImGui::GetIO();
    if (io.ConfigFlags & ImGuiConfigFlags_NoMouseCursorChange)
        return;
    
    ImGui_ImplSDL2_Data* bd = ImGui_ImplSDL2_GetBackendData();

    ImGuiMouseCursor imgui_cursor = ImGui::GetMouseCursor();
    if (io.MouseDrawCursor || imgui_cursor == ImGuiMouseCursor_None)
    {
        // Hide OS mouse cursor if imgui is drawing it or if it wants no cursor
        SDL_ShowCursor(SDL_FALSE);
    }
    else
    {
        // Show OS mouse cursor
        SDL_SetCursor(bd->MouseCursors[imgui_cursor] ? bd->MouseCursors[imgui_cursor] : bd->MouseCursors[ImGuiMouseCursor_Arrow]);
        SDL_ShowCursor(SDL_TRUE);
    }
}

void ImGui_ImplSDL2_NewFrame()
{
    ImGui_ImplSDL2_Data* bd = ImGui_ImplSDL2_GetBackendData();
    ImGuiIO& io = ImGui::GetIO();

    // Setup display size
    int w, h;
    int display_w, display_h;
    SDL_GetWindowSize(bd->Window, &w, &h);
    if (SDL_GetWindowFlags(bd->Window) & SDL_WINDOW_MINIMIZED)
        w = h = 0;
    
    if (bd->Renderer != NULL)
        SDL_GetRendererOutputSize(bd->Renderer, &display_w, &display_h);
    else
        SDL_GL_GetDrawableSize(bd->Window, &display_w, &display_h);
    
    io.DisplaySize = ImVec2((float)w, (float)h);
    if (w > 0 && h > 0)
        io.DisplayFramebufferScale = ImVec2((float)display_w / w, (float)display_h / h);

    // Setup time step
    static Uint64 frequency = SDL_GetPerformanceFrequency();
    Uint64 current_time = SDL_GetPerformanceCounter();
    io.DeltaTime = bd->Time > 0 ? (float)((double)(current_time - bd->Time) / frequency) : (float)(1.0f / 60.0f);
    bd->Time = current_time;

    ImGui_ImplSDL2_UpdateMouseData();
    ImGui_ImplSDL2_UpdateMouseCursor();
}

bool ImGui_ImplSDL2_InitForOpenGL(SDL_Window* window, void* sdl_gl_context)
{
    ImGuiIO& io = ImGui::GetIO();
    IM_ASSERT(io.BackendPlatformUserData == NULL && "Already initialized a platform backend!");

    // Setup backend capabilities flags
    ImGui_ImplSDL2_Data* bd = IM_NEW(ImGui_ImplSDL2_Data)();
    io.BackendPlatformUserData = (void*)bd;
    io.BackendPlatformName = "imgui_impl_sdl2";
    io.BackendFlags |= ImGuiBackendFlags_HasMouseCursors;       // We can honor GetMouseCursor() values
    io.BackendFlags |= ImGuiBackendFlags_HasSetMousePos;        // We can honor io.WantSetMousePos requests

    bd->Window = window;
    bd->GLContext = (SDL_GLContext)sdl_gl_context;

    // Setup mouse cursors
    bd->MouseCursors[ImGuiMouseCursor_Arrow] = SDL_CreateSystemCursor(SDL_SYSTEM_CURSOR_ARROW);
    bd->MouseCursors[ImGuiMouseCursor_TextInput] = SDL_CreateSystemCursor(SDL_SYSTEM_CURSOR_IBEAM);
    bd->MouseCursors[ImGuiMouseCursor_ResizeAll] = SDL_CreateSystemCursor(SDL_SYSTEM_CURSOR_SIZEALL);
    bd->MouseCursors[ImGuiMouseCursor_ResizeNS] = SDL_CreateSystemCursor(SDL_SYSTEM_CURSOR_SIZENS);
    bd->MouseCursors[ImGuiMouseCursor_ResizeEW] = SDL_CreateSystemCursor(SDL_SYSTEM_CURSOR_SIZEWE);
    bd->MouseCursors[ImGuiMouseCursor_ResizeNESW] = SDL_CreateSystemCursor(SDL_SYSTEM_CURSOR_SIZENESW);
    bd->MouseCursors[ImGuiMouseCursor_ResizeNWSE] = SDL_CreateSystemCursor(SDL_SYSTEM_CURSOR_SIZENWSE);
    bd->MouseCursors[ImGuiMouseCursor_Hand] = SDL_CreateSystemCursor(SDL_SYSTEM_CURSOR_HAND);
    bd->MouseCursors[ImGuiMouseCursor_NotAllowed] = SDL_CreateSystemCursor(SDL_SYSTEM_CURSOR_NO);

    // Set platform dependent data in viewport
    // Our mouse update function expect PlatformHandle to be filled for the main viewport
    ImGuiViewport* main_viewport = ImGui::GetMainViewport();
    main_viewport->PlatformHandleRaw = NULL;

    // Set SDL hint to receive mouse click events on window focus, otherwise SDL doesn't emit the event.
    SDL_SetHint(SDL_HINT_MOUSE_FOCUS_CLICKTHROUGH, "1");

    // Set up the clipboard
    io.SetClipboardTextFn = ImGui_ImplSDL2_SetClipboardText;
    io.GetClipboardTextFn = ImGui_ImplSDL2_GetClipboardText;
    io.ClipboardUserData = NULL;

    return true;
}

void ImGui_ImplSDL2_Shutdown()
{
    ImGui_ImplSDL2_Data* bd = ImGui_ImplSDL2_GetBackendData();
    IM_ASSERT(bd != NULL && "No platform backend to shutdown, or already shutdown?");
    ImGuiIO& io = ImGui::GetIO();

    // No clipboard data to free
    
    // Destroy last known clipboard data
    for (ImGuiMouseCursor cursor_n = 0; cursor_n < ImGuiMouseCursor_COUNT; cursor_n++)
        if (bd->MouseCursors[cursor_n])
            SDL_FreeCursor(bd->MouseCursors[cursor_n]);

    io.BackendPlatformName = NULL;
    io.BackendPlatformUserData = NULL;
    IM_DELETE(bd);
}

bool ImGui_ImplSDL2_InitForD3D(SDL_Window* window)
{
    return ImGui_ImplSDL2_InitForOpenGL(window, NULL);
}

bool ImGui_ImplSDL2_InitForMetal(SDL_Window* window)
{
    return ImGui_ImplSDL2_InitForOpenGL(window, NULL);
}

bool ImGui_ImplSDL2_InitForVulkan(SDL_Window* window)
{
    return ImGui_ImplSDL2_InitForOpenGL(window, NULL);
}

bool ImGui_ImplSDL2_InitForSDLRenderer(SDL_Window* window, SDL_Renderer* renderer)
{
    ImGui_ImplSDL2_Data* bd = ImGui_ImplSDL2_GetBackendData();
    bd->Renderer = renderer;
    return true;
}

bool ImGui_ImplSDL2_InitForOther(SDL_Window* window)
{
    return ImGui_ImplSDL2_InitForOpenGL(window, NULL);
}