import Cocoa

// MARK: - Color Theme (Soft Pink & Purple)
struct Theme {
    static let bg        = NSColor(r: 0x1e, g: 0x17, b: 0x2a)
    static let bg2       = NSColor(r: 0x17, g: 0x12, b: 0x23)
    static let bgCard    = NSColor(r: 0x25, g: 0x1d, b: 0x34)
    static let bgHover   = NSColor(r: 0x36, g: 0x2b, b: 0x4a)
    static let text      = NSColor(r: 0xf0, g: 0xe6, b: 0xf6)
    static let textSub   = NSColor(r: 0xd4, g: 0xc6, b: 0xe0)
    static let textMuted = NSColor(r: 0x7e, g: 0x6b, b: 0x9b)
    static let border    = NSColor(r: 0x3a, g: 0x2e, b: 0x50)
    static let blue      = NSColor(r: 0xa8, g: 0xb4, b: 0xe0)
    static let green     = NSColor(r: 0xa8, g: 0xd8, b: 0xb9)
    static let purple    = NSColor(r: 0xc4, g: 0xa1, b: 0xe0)
    static let orange    = NSColor(r: 0xe0, g: 0xb0, b: 0x9a)
    static let red       = NSColor(r: 0xe0, g: 0x8e, b: 0x9e)
    static let cyan      = NSColor(r: 0xc9, g: 0xb0, b: 0xe8)
    static let yellow    = NSColor(r: 0xd8, g: 0xca, b: 0xa8)
    static let keyBg     = NSColor(r: 0x30, g: 0x25, b: 0x42)
    static let keyBorder = NSColor(r: 0x5a, g: 0x48, b: 0x78)
    static let pink      = NSColor(r: 0xe0, g: 0xa0, b: 0xc0)
}

extension NSColor {
    convenience init(r: Int, g: Int, b: Int, a: CGFloat = 1.0) {
        self.init(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: a)
    }
}

// MARK: - Data Models
struct KeyBinding {
    let keys: String
    let mode: String
    let desc: String
    let category: String
    let source: String
}

struct Setting {
    let key: String
    let value: String
    let desc: String
    let category: String
}

struct ModuleInfo {
    let name: String
    let desc: String
}

// MARK: - Tab Type
enum Tab: Int, CaseIterable {
    case neovim = 0, wezterm, aerospace, hammerspoon

    var title: String {
        switch self {
        case .neovim: return "Neovim"
        case .wezterm: return "WezTerm"
        case .aerospace: return "AeroSpace"
        case .hammerspoon: return "Hammerspoon"
        }
    }
    var color: NSColor {
        switch self {
        case .neovim: return Theme.pink
        case .wezterm: return Theme.purple
        case .aerospace: return Theme.green
        case .hammerspoon: return Theme.blue
        }
    }
    var icon: String {
        switch self {
        case .neovim: return "\u{26A1}"
        case .wezterm: return "\u{1F4BB}"
        case .aerospace: return "\u{1FA9F}"
        case .hammerspoon: return "\u{1F528}"
        }
    }
}

// MARK: - Neovim Data
let nvimCategories: [(id: String, title: String, icon: String)] = [
    ("general","General","\u{2699}"),("window","Window","\u{25A6}"),("buffer","Buffer","\u{1F4C4}"),
    ("move","Move / Edit","\u{2194}"),("search","Search / Find","\u{1F50D}"),("lsp","LSP","\u{26A1}"),
    ("dap","DAP (Debug)","\u{1F41B}"),("git","Git","\u{1F4C8}"),("diag","Diagnostics","\u{26A0}"),
    ("term","Terminal",">_"),("ui","UI Toggle","\u{1F3A8}"),("tree","Neo-tree","\u{1F4C1}"),
    ("laravel","Laravel","\u{26AB}")
]

let nvimBindings: [KeyBinding] = [
    // General
    KeyBinding(keys:"Space",mode:"n",desc:"Leader key",category:"general",source:"lazyvim"),
    KeyBinding(keys:"Esc",mode:"i",desc:"Escape / hlsearch clear",category:"general",source:"lazyvim"),
    KeyBinding(keys:"Esc Esc",mode:"n",desc:"Escape / hlsearch clear",category:"general",source:"lazyvim"),
    KeyBinding(keys:"Ctrl+s",mode:"n,i,x,s",desc:"Save file",category:"general",source:"lazyvim"),
    KeyBinding(keys:"Leader q q",mode:"n",desc:"Quit all",category:"general",source:"lazyvim"),
    KeyBinding(keys:"Leader u i",mode:"n",desc:"Inspect position (Treesitter)",category:"general",source:"lazyvim"),
    KeyBinding(keys:"Leader L",mode:"n",desc:"LazyVim changelog",category:"general",source:"lazyvim"),
    KeyBinding(keys:"Leader l",mode:"n",desc:"Lazy plugin manager",category:"general",source:"lazyvim"),
    // Window
    KeyBinding(keys:"Ctrl+h",mode:"n",desc:"Go to left window",category:"window",source:"lazyvim"),
    KeyBinding(keys:"Ctrl+j",mode:"n",desc:"Go to lower window",category:"window",source:"lazyvim"),
    KeyBinding(keys:"Ctrl+k",mode:"n",desc:"Go to upper window",category:"window",source:"lazyvim"),
    KeyBinding(keys:"Ctrl+l",mode:"n",desc:"Go to right window",category:"window",source:"lazyvim"),
    KeyBinding(keys:"Leader w w",mode:"n",desc:"Other window",category:"window",source:"lazyvim"),
    KeyBinding(keys:"Leader w d",mode:"n",desc:"Delete window",category:"window",source:"lazyvim"),
    KeyBinding(keys:"Leader -",mode:"n",desc:"Split below",category:"window",source:"lazyvim"),
    KeyBinding(keys:"Leader |",mode:"n",desc:"Split right",category:"window",source:"lazyvim"),
    KeyBinding(keys:"Leader w m",mode:"n",desc:"Maximize toggle",category:"window",source:"lazyvim"),
    KeyBinding(keys:"Ctrl+Up",mode:"n",desc:"Window height +",category:"window",source:"lazyvim"),
    KeyBinding(keys:"Ctrl+Down",mode:"n",desc:"Window height -",category:"window",source:"lazyvim"),
    KeyBinding(keys:"Ctrl+Left",mode:"n",desc:"Window width -",category:"window",source:"lazyvim"),
    KeyBinding(keys:"Ctrl+Right",mode:"n",desc:"Window width +",category:"window",source:"lazyvim"),
    KeyBinding(keys:"Leader Up",mode:"n",desc:"Resize: height -2",category:"window",source:"custom"),
    KeyBinding(keys:"Leader Down",mode:"n",desc:"Resize: height +2",category:"window",source:"custom"),
    KeyBinding(keys:"Leader Left",mode:"n",desc:"Resize: width -2",category:"window",source:"custom"),
    KeyBinding(keys:"Leader Right",mode:"n",desc:"Resize: width +2",category:"window",source:"custom"),
    // Buffer
    KeyBinding(keys:"Shift+h",mode:"n",desc:"Previous buffer",category:"buffer",source:"lazyvim"),
    KeyBinding(keys:"Shift+l",mode:"n",desc:"Next buffer",category:"buffer",source:"lazyvim"),
    KeyBinding(keys:"[ b",mode:"n",desc:"Previous buffer",category:"buffer",source:"lazyvim"),
    KeyBinding(keys:"] b",mode:"n",desc:"Next buffer",category:"buffer",source:"lazyvim"),
    KeyBinding(keys:"Leader b b",mode:"n",desc:"Switch to other buffer",category:"buffer",source:"lazyvim"),
    KeyBinding(keys:"Leader `",mode:"n",desc:"Switch to other buffer",category:"buffer",source:"lazyvim"),
    KeyBinding(keys:"Leader b d",mode:"n",desc:"Delete buffer",category:"buffer",source:"lazyvim"),
    KeyBinding(keys:"Leader b D",mode:"n",desc:"Delete buffer + window",category:"buffer",source:"lazyvim"),
    KeyBinding(keys:"Leader b o",mode:"n",desc:"Delete other buffers",category:"buffer",source:"lazyvim"),
    KeyBinding(keys:"Leader b p",mode:"n",desc:"Toggle pin buffer",category:"buffer",source:"lazyvim"),
    KeyBinding(keys:"Leader b P",mode:"n",desc:"Delete non-pinned buffers",category:"buffer",source:"lazyvim"),
    // Move
    KeyBinding(keys:"Alt+j",mode:"n",desc:"Move line down",category:"move",source:"lazyvim"),
    KeyBinding(keys:"Alt+k",mode:"n",desc:"Move line up",category:"move",source:"lazyvim"),
    KeyBinding(keys:"Alt+j",mode:"i",desc:"Move line down",category:"move",source:"lazyvim"),
    KeyBinding(keys:"Alt+k",mode:"i",desc:"Move line up",category:"move",source:"lazyvim"),
    KeyBinding(keys:"Alt+j",mode:"v",desc:"Move selection down",category:"move",source:"lazyvim"),
    KeyBinding(keys:"Alt+k",mode:"v",desc:"Move selection up",category:"move",source:"lazyvim"),
    KeyBinding(keys:"<",mode:"v",desc:"Indent left (stay visual)",category:"move",source:"lazyvim"),
    KeyBinding(keys:">",mode:"v",desc:"Indent right (stay visual)",category:"move",source:"lazyvim"),
    KeyBinding(keys:"J",mode:"n",desc:"Join lines (cursor stays)",category:"move",source:"lazyvim"),
    KeyBinding(keys:"n",mode:"n,x,o",desc:"Next search result",category:"move",source:"lazyvim"),
    KeyBinding(keys:"N",mode:"n,x,o",desc:"Previous search result",category:"move",source:"lazyvim"),
    // Search
    KeyBinding(keys:"Leader f f",mode:"n",desc:"Find files (root)",category:"search",source:"lazyvim"),
    KeyBinding(keys:"Leader f F",mode:"n",desc:"Find files (cwd)",category:"search",source:"lazyvim"),
    KeyBinding(keys:"Leader f r",mode:"n",desc:"Recent files",category:"search",source:"lazyvim"),
    KeyBinding(keys:"Leader f R",mode:"n",desc:"Recent files (cwd)",category:"search",source:"lazyvim"),
    KeyBinding(keys:"Leader Space",mode:"n",desc:"Find files (root)",category:"search",source:"lazyvim"),
    KeyBinding(keys:"Leader ,",mode:"n",desc:"Switch buffer",category:"search",source:"lazyvim"),
    KeyBinding(keys:"Leader /",mode:"n",desc:"Grep (root)",category:"search",source:"lazyvim"),
    KeyBinding(keys:"Leader :",mode:"n",desc:"Command history",category:"search",source:"lazyvim"),
    KeyBinding(keys:"Leader s g",mode:"n",desc:"Grep (root)",category:"search",source:"lazyvim"),
    KeyBinding(keys:"Leader s G",mode:"n",desc:"Grep (cwd)",category:"search",source:"lazyvim"),
    KeyBinding(keys:"Leader s w",mode:"n",desc:"Word under cursor (root)",category:"search",source:"lazyvim"),
    KeyBinding(keys:"Leader s W",mode:"n",desc:"Word under cursor (cwd)",category:"search",source:"lazyvim"),
    KeyBinding(keys:"Leader s b",mode:"n",desc:"Buffer search",category:"search",source:"lazyvim"),
    KeyBinding(keys:"Leader s h",mode:"n",desc:"Help pages",category:"search",source:"lazyvim"),
    KeyBinding(keys:"Leader s k",mode:"n",desc:"Keymaps search",category:"search",source:"lazyvim"),
    KeyBinding(keys:"Leader s m",mode:"n",desc:"Jump to mark",category:"search",source:"lazyvim"),
    KeyBinding(keys:"Leader s r",mode:"n",desc:"Resume last search",category:"search",source:"lazyvim"),
    KeyBinding(keys:"Leader s s",mode:"n",desc:"Goto symbol",category:"search",source:"lazyvim"),
    KeyBinding(keys:"Leader s S",mode:"n",desc:"Goto symbol (workspace)",category:"search",source:"lazyvim"),
    KeyBinding(keys:"Leader s n",mode:"n",desc:"Notifications",category:"search",source:"lazyvim"),
    KeyBinding(keys:"Leader s c",mode:"n",desc:"Command history",category:"search",source:"lazyvim"),
    KeyBinding(keys:"Leader s C",mode:"n",desc:"Commands",category:"search",source:"lazyvim"),
    KeyBinding(keys:"Leader s d",mode:"n",desc:"Document diagnostics",category:"search",source:"lazyvim"),
    KeyBinding(keys:"Leader s D",mode:"n",desc:"Workspace diagnostics",category:"search",source:"lazyvim"),
    KeyBinding(keys:"Leader s a",mode:"n",desc:"Auto commands",category:"search",source:"lazyvim"),
    KeyBinding(keys:"Leader s H",mode:"n",desc:"Highlight groups",category:"search",source:"lazyvim"),
    KeyBinding(keys:"Leader s o",mode:"n",desc:"Options",category:"search",source:"lazyvim"),
    KeyBinding(keys:"Leader s q",mode:"n",desc:"Quickfix list",category:"search",source:"lazyvim"),
    KeyBinding(keys:"Leader s t",mode:"n",desc:"Todo list",category:"search",source:"lazyvim"),
    KeyBinding(keys:"Leader s T",mode:"n",desc:"Todo / Fix / Fixme",category:"search",source:"lazyvim"),
    // LSP
    KeyBinding(keys:"g d",mode:"n",desc:"Goto definition",category:"lsp",source:"lazyvim"),
    KeyBinding(keys:"g r",mode:"n",desc:"References",category:"lsp",source:"lazyvim"),
    KeyBinding(keys:"g D",mode:"n",desc:"Goto declaration",category:"lsp",source:"lazyvim"),
    KeyBinding(keys:"g I",mode:"n",desc:"Goto implementation",category:"lsp",source:"lazyvim"),
    KeyBinding(keys:"g y",mode:"n",desc:"Goto type definition",category:"lsp",source:"lazyvim"),
    KeyBinding(keys:"K",mode:"n",desc:"Hover documentation",category:"lsp",source:"lazyvim"),
    KeyBinding(keys:"g K",mode:"n",desc:"Signature help",category:"lsp",source:"lazyvim"),
    KeyBinding(keys:"Ctrl+k",mode:"i",desc:"Signature help",category:"lsp",source:"lazyvim"),
    KeyBinding(keys:"Leader c a",mode:"n,v",desc:"Code action",category:"lsp",source:"lazyvim"),
    KeyBinding(keys:"Leader c r",mode:"n",desc:"Rename",category:"lsp",source:"lazyvim"),
    KeyBinding(keys:"Leader c R",mode:"n",desc:"Rename file",category:"lsp",source:"lazyvim"),
    KeyBinding(keys:"Leader c l",mode:"n",desc:"LSP info",category:"lsp",source:"lazyvim"),
    KeyBinding(keys:"Leader c f",mode:"n,v",desc:"Format",category:"lsp",source:"lazyvim"),
    KeyBinding(keys:"Leader c d",mode:"n",desc:"Line diagnostics",category:"lsp",source:"lazyvim"),
    KeyBinding(keys:"Leader c s",mode:"n",desc:"Source action",category:"lsp",source:"lazyvim"),
    KeyBinding(keys:"[ [",mode:"n",desc:"Previous reference",category:"lsp",source:"lazyvim"),
    KeyBinding(keys:"] ]",mode:"n",desc:"Next reference",category:"lsp",source:"lazyvim"),
    // DAP
    KeyBinding(keys:"Leader d b",mode:"n",desc:"Toggle breakpoint",category:"dap",source:"lazyvim"),
    KeyBinding(keys:"Leader d B",mode:"n",desc:"Breakpoint condition",category:"dap",source:"lazyvim"),
    KeyBinding(keys:"Leader d c",mode:"n",desc:"Continue",category:"dap",source:"lazyvim"),
    KeyBinding(keys:"Leader d C",mode:"n",desc:"Run to cursor",category:"dap",source:"lazyvim"),
    KeyBinding(keys:"Leader d a",mode:"n",desc:"Run with args",category:"dap",source:"lazyvim"),
    KeyBinding(keys:"Leader d g",mode:"n",desc:"Go to line (no execute)",category:"dap",source:"lazyvim"),
    KeyBinding(keys:"Leader d i",mode:"n",desc:"Step into",category:"dap",source:"lazyvim"),
    KeyBinding(keys:"Leader d j",mode:"n",desc:"Down (stack frame)",category:"dap",source:"lazyvim"),
    KeyBinding(keys:"Leader d k",mode:"n",desc:"Up (stack frame)",category:"dap",source:"lazyvim"),
    KeyBinding(keys:"Leader d l",mode:"n",desc:"Run last",category:"dap",source:"lazyvim"),
    KeyBinding(keys:"Leader d o",mode:"n",desc:"Step over",category:"dap",source:"lazyvim"),
    KeyBinding(keys:"Leader d O",mode:"n",desc:"Step out",category:"dap",source:"lazyvim"),
    KeyBinding(keys:"Leader d p",mode:"n",desc:"Pause",category:"dap",source:"lazyvim"),
    KeyBinding(keys:"Leader d r",mode:"n",desc:"Toggle REPL",category:"dap",source:"lazyvim"),
    KeyBinding(keys:"Leader d s",mode:"n",desc:"Session",category:"dap",source:"lazyvim"),
    KeyBinding(keys:"Leader d t",mode:"n",desc:"Terminate",category:"dap",source:"lazyvim"),
    KeyBinding(keys:"Leader d u",mode:"n",desc:"DAP UI toggle",category:"dap",source:"lazyvim"),
    KeyBinding(keys:"Leader d w",mode:"n",desc:"Widgets",category:"dap",source:"lazyvim"),
    KeyBinding(keys:"Leader d e",mode:"n,v",desc:"Eval expression",category:"dap",source:"lazyvim"),
    // Git
    KeyBinding(keys:"Leader g g",mode:"n",desc:"Lazygit (root)",category:"git",source:"lazyvim"),
    KeyBinding(keys:"Leader g G",mode:"n",desc:"Lazygit (cwd)",category:"git",source:"lazyvim"),
    KeyBinding(keys:"Leader g b",mode:"n",desc:"Git blame line",category:"git",source:"lazyvim"),
    KeyBinding(keys:"Leader g f",mode:"n",desc:"Lazygit file history",category:"git",source:"lazyvim"),
    KeyBinding(keys:"Leader g l",mode:"n",desc:"Lazygit log",category:"git",source:"lazyvim"),
    KeyBinding(keys:"Leader g L",mode:"n",desc:"Lazygit log (cwd)",category:"git",source:"lazyvim"),
    KeyBinding(keys:"] h",mode:"n",desc:"Next hunk",category:"git",source:"lazyvim"),
    KeyBinding(keys:"[ h",mode:"n",desc:"Previous hunk",category:"git",source:"lazyvim"),
    KeyBinding(keys:"Leader g h s",mode:"n",desc:"Stage hunk",category:"git",source:"lazyvim"),
    KeyBinding(keys:"Leader g h r",mode:"n",desc:"Reset hunk",category:"git",source:"lazyvim"),
    KeyBinding(keys:"Leader g h S",mode:"n",desc:"Stage buffer",category:"git",source:"lazyvim"),
    KeyBinding(keys:"Leader g h u",mode:"n",desc:"Undo stage hunk",category:"git",source:"lazyvim"),
    KeyBinding(keys:"Leader g h R",mode:"n",desc:"Reset buffer",category:"git",source:"lazyvim"),
    KeyBinding(keys:"Leader g h p",mode:"n",desc:"Preview hunk inline",category:"git",source:"lazyvim"),
    KeyBinding(keys:"Leader g h d",mode:"n",desc:"Diff this",category:"git",source:"lazyvim"),
    KeyBinding(keys:"Leader g h b",mode:"n",desc:"Blame line (full)",category:"git",source:"lazyvim"),
    // Diagnostics
    KeyBinding(keys:"] d",mode:"n",desc:"Next diagnostic",category:"diag",source:"lazyvim"),
    KeyBinding(keys:"[ d",mode:"n",desc:"Previous diagnostic",category:"diag",source:"lazyvim"),
    KeyBinding(keys:"] e",mode:"n",desc:"Next error",category:"diag",source:"lazyvim"),
    KeyBinding(keys:"[ e",mode:"n",desc:"Previous error",category:"diag",source:"lazyvim"),
    KeyBinding(keys:"] w",mode:"n",desc:"Next warning",category:"diag",source:"lazyvim"),
    KeyBinding(keys:"[ w",mode:"n",desc:"Previous warning",category:"diag",source:"lazyvim"),
    KeyBinding(keys:"Leader x x",mode:"n",desc:"Document diagnostics (Trouble)",category:"diag",source:"lazyvim"),
    KeyBinding(keys:"Leader x X",mode:"n",desc:"Workspace diagnostics (Trouble)",category:"diag",source:"lazyvim"),
    KeyBinding(keys:"Leader x L",mode:"n",desc:"Location list (Trouble)",category:"diag",source:"lazyvim"),
    KeyBinding(keys:"Leader x Q",mode:"n",desc:"Quickfix list (Trouble)",category:"diag",source:"lazyvim"),
    KeyBinding(keys:"[ q",mode:"n",desc:"Previous quickfix",category:"diag",source:"lazyvim"),
    KeyBinding(keys:"] q",mode:"n",desc:"Next quickfix",category:"diag",source:"lazyvim"),
    KeyBinding(keys:"Leader x t",mode:"n",desc:"Todo (Trouble)",category:"diag",source:"lazyvim"),
    KeyBinding(keys:"Leader x T",mode:"n",desc:"Todo / Fix / Fixme (Trouble)",category:"diag",source:"lazyvim"),
    // Terminal
    KeyBinding(keys:"Ctrl+/",mode:"n",desc:"Toggle terminal",category:"term",source:"lazyvim"),
    KeyBinding(keys:"Ctrl+_",mode:"n",desc:"Toggle terminal (alias)",category:"term",source:"lazyvim"),
    KeyBinding(keys:"Esc Esc",mode:"t",desc:"Normal mode in terminal",category:"term",source:"lazyvim"),
    KeyBinding(keys:"Ctrl+h",mode:"t",desc:"Go to left window",category:"term",source:"lazyvim"),
    KeyBinding(keys:"Ctrl+j",mode:"t",desc:"Go to lower window",category:"term",source:"lazyvim"),
    KeyBinding(keys:"Ctrl+k",mode:"t",desc:"Go to upper window",category:"term",source:"lazyvim"),
    KeyBinding(keys:"Ctrl+l",mode:"t",desc:"Go to right window",category:"term",source:"lazyvim"),
    KeyBinding(keys:"Leader f t",mode:"n",desc:"Terminal (root)",category:"term",source:"lazyvim"),
    KeyBinding(keys:"Leader f T",mode:"n",desc:"Terminal (cwd)",category:"term",source:"lazyvim"),
    // UI Toggle
    KeyBinding(keys:"Leader u f",mode:"n",desc:"Toggle auto format (global)",category:"ui",source:"lazyvim"),
    KeyBinding(keys:"Leader u F",mode:"n",desc:"Toggle auto format (buffer)",category:"ui",source:"lazyvim"),
    KeyBinding(keys:"Leader u s",mode:"n",desc:"Toggle spelling",category:"ui",source:"lazyvim"),
    KeyBinding(keys:"Leader u w",mode:"n",desc:"Toggle word wrap",category:"ui",source:"lazyvim"),
    KeyBinding(keys:"Leader u L",mode:"n",desc:"Toggle relative line numbers",category:"ui",source:"lazyvim"),
    KeyBinding(keys:"Leader u l",mode:"n",desc:"Toggle line numbers",category:"ui",source:"lazyvim"),
    KeyBinding(keys:"Leader u d",mode:"n",desc:"Toggle diagnostics",category:"ui",source:"lazyvim"),
    KeyBinding(keys:"Leader u c",mode:"n",desc:"Toggle conceal",category:"ui",source:"lazyvim"),
    KeyBinding(keys:"Leader u T",mode:"n",desc:"Toggle treesitter highlight",category:"ui",source:"lazyvim"),
    KeyBinding(keys:"Leader u b",mode:"n",desc:"Toggle background dark/light",category:"ui",source:"lazyvim"),
    KeyBinding(keys:"Leader u h",mode:"n",desc:"Toggle inlay hints",category:"ui",source:"lazyvim"),
    KeyBinding(keys:"Leader u g",mode:"n",desc:"Toggle indent guides",category:"ui",source:"lazyvim"),
    KeyBinding(keys:"Leader u D",mode:"n",desc:"Toggle dim inactive",category:"ui",source:"lazyvim"),
    // Neo-tree
    KeyBinding(keys:"Leader e",mode:"n",desc:"Explorer (root) - right side",category:"tree",source:"lazyvim"),
    KeyBinding(keys:"Leader E",mode:"n",desc:"Explorer (cwd) - right side",category:"tree",source:"lazyvim"),
    KeyBinding(keys:"Leader f e",mode:"n",desc:"Explorer (root)",category:"tree",source:"lazyvim"),
    KeyBinding(keys:"Leader f E",mode:"n",desc:"Explorer (cwd)",category:"tree",source:"lazyvim"),
    KeyBinding(keys:"Leader b e",mode:"n",desc:"Buffer explorer",category:"tree",source:"lazyvim"),
    KeyBinding(keys:"Leader g e",mode:"n",desc:"Git explorer",category:"tree",source:"lazyvim"),
    // Laravel
    KeyBinding(keys:"Leader l l",mode:"n",desc:"Laravel Picker",category:"laravel",source:"plugin"),
    KeyBinding(keys:"Ctrl+g",mode:"n",desc:"View Finder",category:"laravel",source:"plugin"),
    KeyBinding(keys:"Leader l a",mode:"n",desc:"Artisan Picker",category:"laravel",source:"plugin"),
    KeyBinding(keys:"Leader l t",mode:"n",desc:"Actions Picker",category:"laravel",source:"plugin"),
    KeyBinding(keys:"Leader l r",mode:"n",desc:"Routes Picker",category:"laravel",source:"plugin"),
    KeyBinding(keys:"Leader l h",mode:"n",desc:"Documentation",category:"laravel",source:"plugin"),
    KeyBinding(keys:"Leader l m",mode:"n",desc:"Make Picker",category:"laravel",source:"plugin"),
    KeyBinding(keys:"Leader l c",mode:"n",desc:"Commands Picker",category:"laravel",source:"plugin"),
    KeyBinding(keys:"Leader l o",mode:"n",desc:"Resources Picker",category:"laravel",source:"plugin"),
    KeyBinding(keys:"Leader l p",mode:"n",desc:"Command Center",category:"laravel",source:"plugin"),
    KeyBinding(keys:"g f",mode:"n",desc:"Enhanced Go to File",category:"laravel",source:"plugin"),
]

// MARK: - WezTerm Data
struct WezTermKey {
    let keys: [String]
    let desc: String
    let category: String
}

let weztermKeys: [WezTermKey] = [
    // Tab
    WezTermKey(keys:["Cmd","T"],desc:"New tab",category:"tab"),
    WezTermKey(keys:["Cmd","W"],desc:"Close current tab (confirm)",category:"tab"),
    // Pane
    WezTermKey(keys:["Cmd","D"],desc:"Split horizontal (right)",category:"pane"),
    WezTermKey(keys:["Cmd","Shift","D"],desc:"Split vertical (bottom)",category:"pane"),
    WezTermKey(keys:["Cmd","Shift","\u{2190}"],desc:"Move to left pane",category:"pane"),
    WezTermKey(keys:["Cmd","Shift","\u{2192}"],desc:"Move to right pane",category:"pane"),
    WezTermKey(keys:["Cmd","Shift","\u{2191}"],desc:"Move to top pane",category:"pane"),
    WezTermKey(keys:["Cmd","Shift","\u{2193}"],desc:"Move to bottom pane",category:"pane"),
    // Font
    WezTermKey(keys:["Cmd","+"],desc:"Font size +1",category:"font"),
    WezTermKey(keys:["Cmd","-"],desc:"Font size -1",category:"font"),
    WezTermKey(keys:["Cmd","0"],desc:"Font size reset",category:"font"),
    // Other
    WezTermKey(keys:["Shift","Enter"],desc:"Send newline",category:"other"),
]

let weztermKeyCats: [(id: String, title: String)] = [
    ("tab","Tab"),("pane","Pane"),("font","Font Size"),("other","Other")
]

let weztermSettings: [Setting] = [
    // Appearance
    Setting(key:"color_scheme",value:"Selenized Dark (Gogh)",desc:"Color scheme / theme",category:"appearance"),
    Setting(key:"window_background_opacity",value:"0.8",desc:"Background transparency (80%)",category:"appearance"),
    Setting(key:"macos_window_background_blur",value:"20",desc:"Background blur radius (macOS)",category:"appearance"),
    // Font
    Setting(key:"font",value:"JetBrains Mono",desc:"Primary font (+ Hiragino Sans, Menlo, Monaco)",category:"font"),
    Setting(key:"font_size",value:"14",desc:"Font size in points",category:"font"),
    Setting(key:"harfbuzz_features",value:"calt=0, liga=0, dlig=0",desc:"Disabled ligatures",category:"font"),
    // Window
    Setting(key:"window_decorations",value:"RESIZE",desc:"No titlebar, resize only",category:"window"),
    Setting(key:"window_padding",value:"8x / 6y",desc:"Window padding (left/right 8, top/bottom 6)",category:"window"),
    Setting(key:"enable_tab_bar",value:"true",desc:"Tab bar always visible",category:"window"),
    Setting(key:"hide_tab_bar_if_only_one_tab",value:"false",desc:"Show tab bar even with one tab",category:"window"),
    // Performance
    Setting(key:"front_end",value:"WebGpu",desc:"GPU rendering backend",category:"performance"),
    Setting(key:"max_fps",value:"120",desc:"Maximum frame rate",category:"performance"),
    Setting(key:"animation_fps",value:"60",desc:"Animation frame rate",category:"performance"),
    // Behavior
    Setting(key:"scrollback_lines",value:"10000",desc:"Scrollback buffer lines",category:"behavior"),
    Setting(key:"audible_bell",value:"Disabled",desc:"No bell sound",category:"behavior"),
    Setting(key:"use_ime",value:"true",desc:"IME input enabled",category:"behavior"),
    Setting(key:"send_composed_key_when_right_alt_is_pressed",value:"true",desc:"Right Alt acts as Alt",category:"behavior"),
]

let weztermSettingCats: [(id: String, title: String)] = [
    ("appearance","Appearance"),("font","Font"),("window","Window"),("performance","Performance"),("behavior","Behavior")
]

// MARK: - AeroSpace Data
struct ASKey {
    let keys: [String]
    let desc: String
    let category: String
}

let asKeys: [ASKey] = [
    // Workspace
    ASKey(keys:["Alt","1"],desc:"Switch to Workspace 1",category:"workspace"),
    ASKey(keys:["Alt","2"],desc:"Switch to Workspace 2",category:"workspace"),
    ASKey(keys:["Alt","3"],desc:"Switch to Workspace 3",category:"workspace"),
    ASKey(keys:["Alt","4"],desc:"Switch to Workspace 4",category:"workspace"),
    ASKey(keys:["Alt","5"],desc:"Switch to Workspace 5",category:"workspace"),
    ASKey(keys:["Alt","Shift","1"],desc:"Move window to Workspace 1 (follow)",category:"workspace"),
    ASKey(keys:["Alt","Shift","2"],desc:"Move window to Workspace 2 (follow)",category:"workspace"),
    ASKey(keys:["Alt","Shift","3"],desc:"Move window to Workspace 3 (follow)",category:"workspace"),
    ASKey(keys:["Alt","Shift","4"],desc:"Move window to Workspace 4 (follow)",category:"workspace"),
    ASKey(keys:["Alt","Shift","5"],desc:"Move window to Workspace 5 (follow)",category:"workspace"),
    // Focus
    ASKey(keys:["Alt","H"],desc:"Focus left",category:"focus"),
    ASKey(keys:["Alt","J"],desc:"Focus down",category:"focus"),
    ASKey(keys:["Alt","K"],desc:"Focus up",category:"focus"),
    ASKey(keys:["Alt","L"],desc:"Focus right",category:"focus"),
    // Move
    ASKey(keys:["Alt","Shift","H"],desc:"Move window left",category:"move"),
    ASKey(keys:["Alt","Shift","J"],desc:"Move window down",category:"move"),
    ASKey(keys:["Alt","Shift","K"],desc:"Move window up",category:"move"),
    ASKey(keys:["Alt","Shift","L"],desc:"Move window right",category:"move"),
    // Resize
    ASKey(keys:["Alt","Ctrl","H"],desc:"Resize width -50",category:"resize"),
    ASKey(keys:["Alt","Ctrl","J"],desc:"Resize height +50",category:"resize"),
    ASKey(keys:["Alt","Ctrl","K"],desc:"Resize height -50",category:"resize"),
    ASKey(keys:["Alt","Ctrl","L"],desc:"Resize width +50",category:"resize"),
    // Layout
    ASKey(keys:["Alt",";"],desc:"Fullscreen toggle",category:"layout"),
    ASKey(keys:["Alt","/"],desc:"Toggle tiles horizontal/vertical",category:"layout"),
    ASKey(keys:["Alt","Shift","F"],desc:"Toggle floating/tiling",category:"layout"),
    ASKey(keys:["Alt","E"],desc:"Join with right",category:"layout"),
    ASKey(keys:["Alt","W"],desc:"Join with down",category:"layout"),
    // Monitor
    ASKey(keys:["Alt","S"],desc:"Move window to next monitor",category:"monitor"),
    ASKey(keys:["Alt","A"],desc:"Move window to main monitor",category:"monitor"),
]

let asKeyCats: [(id: String, title: String)] = [
    ("workspace","Workspace"),("focus","Focus"),("move","Move"),
    ("resize","Resize"),("layout","Layout"),("monitor","Monitor")
]

let asSettings: [Setting] = [
    Setting(key:"start-at-login",value:"true",desc:"Launch at login",category:"general"),
    Setting(key:"default-root-container-layout",value:"tiles",desc:"Default layout mode",category:"general"),
    Setting(key:"default-root-container-orientation",value:"auto",desc:"Auto orientation based on window aspect",category:"general"),
    Setting(key:"enable-normalization-flatten-containers",value:"true",desc:"Flatten nested containers",category:"general"),
    Setting(key:"on-focused-monitor-changed",value:"move-mouse monitor-lazy-center",desc:"Mouse follows focus to monitor center",category:"general"),
    Setting(key:"exec-on-workspace-change",value:"wallpaper.sh",desc:"Change wallpaper per workspace",category:"general"),
    Setting(key:"gaps.inner",value:"5",desc:"Inner gap between windows",category:"gaps"),
    Setting(key:"gaps.outer",value:"5",desc:"Outer gap from screen edges",category:"gaps"),
]

let asSettingCats: [(id: String, title: String)] = [
    ("general","General"),("gaps","Gaps")
]

let asWindowRules: [(app: String, layout: String)] = [
    ("System Preferences", "floating"),
    ("Finder", "floating"),
]

// MARK: - Hammerspoon Data
struct HSKey {
    let keys: [String]
    let desc: String
    let category: String
}

let hsKeys: [HSKey] = [
    // App Switcher
    HSKey(keys:["Alt","F"],desc:"Focus next app window (cycle all apps)",category:"app"),
    HSKey(keys:["Alt","D"],desc:"Focus next window of same app",category:"app"),
    // Launcher
    HSKey(keys:["Cmd","Space"],desc:"App search launcher",category:"launcher"),
    HSKey(keys:["Cmd","Alt","Shift","Space"],desc:"Launch Claude",category:"launcher"),
    HSKey(keys:["Cmd","Alt","Shift","T"],desc:"Launch WezTerm",category:"launcher"),
    HSKey(keys:["Cmd","Alt","Shift","F"],desc:"Launch Finder",category:"launcher"),
    HSKey(keys:["Cmd","Alt","Shift","A"],desc:"Launch Asana",category:"launcher"),
    HSKey(keys:["Cmd","Alt","Shift","C"],desc:"Launch Google Chat",category:"launcher"),
    HSKey(keys:["Cmd","Alt","Shift","S"],desc:"Launch Google Calendar",category:"launcher"),
    HSKey(keys:["Cmd","Alt","Shift","D"],desc:"Launch DBeaver",category:"launcher"),
    HSKey(keys:["Cmd","Alt","Shift","N"],desc:"Launch Notion",category:"launcher"),
    HSKey(keys:["Cmd","Alt","Shift","B"],desc:"Launch Google Chrome",category:"launcher"),
    HSKey(keys:["Cmd","Alt","Shift","M"],desc:"Launch Google Keep",category:"launcher"),
    HSKey(keys:["Cmd","Alt","Shift","Enter"],desc:"Toggle MagicBoard",category:"launcher"),
    HSKey(keys:["Cmd","Alt","Shift","BS"],desc:"Close focused window",category:"launcher"),
    // Clipboard
    HSKey(keys:["Cmd","Shift","V"],desc:"Clipboard history chooser",category:"clipboard"),
    // System
    HSKey(keys:["Ctrl","Alt","R"],desc:"Reload Hammerspoon config",category:"system"),
]

let hsKeyCats: [(id: String, title: String)] = [
    ("app","App Switcher"),
    ("launcher","Launcher / Commands"),("clipboard","Clipboard"),("system","System")
]

let hsModules: [ModuleInfo] = [
    ModuleInfo(name:"app_switcher.lua",desc:"App/window cycling: switch between apps or windows within the same app"),
    ModuleInfo(name:"command_launcher.lua",desc:"Quick-launch apps and toggle MagicBoard via hotkeys"),
    ModuleInfo(name:"clipboard.lua",desc:"Clipboard history manager: 50 entries, persistent, searchable chooser"),
    ModuleInfo(name:"search.lua",desc:"App search launcher with clipboard history integration (replaces Spotlight)"),
]

// MARK: - Helper: Key Badge
func makeKeyBadge(_ text: String) -> NSView {
    let label = NSTextField(labelWithString: text)
    label.font = NSFont.monospacedSystemFont(ofSize: 11, weight: .semibold)
    label.textColor = Theme.cyan
    label.backgroundColor = Theme.keyBg
    label.drawsBackground = true
    label.isBezeled = false
    label.isEditable = false
    label.wantsLayer = true
    label.layer?.cornerRadius = 4
    label.layer?.borderWidth = 1
    label.layer?.borderColor = Theme.keyBorder.cgColor
    label.layer?.masksToBounds = true
    label.alignment = .center
    let size = label.intrinsicContentSize
    label.frame = NSRect(x: 0, y: 0, width: size.width + 12, height: size.height + 4)
    return label
}

func makeKeysView(_ keys: String) -> NSView {
    let container = NSView()
    var x: CGFloat = 0
    let parts = keys.split(separator: " ").map(String.init)
    for (i, part) in parts.enumerated() {
        if part == "+" {
            let plus = NSTextField(labelWithString: "+")
            plus.font = NSFont.monospacedSystemFont(ofSize: 10, weight: .regular)
            plus.textColor = Theme.textMuted
            plus.sizeToFit()
            plus.frame.origin = NSPoint(x: x, y: 2)
            container.addSubview(plus)
            x += plus.frame.width + 2
        } else {
            let badge = makeKeyBadge(part)
            badge.frame.origin = NSPoint(x: x, y: 0)
            container.addSubview(badge)
            x += badge.frame.width + 3
            if i < parts.count - 1 {
                // no separator needed, keys are space-separated
            }
        }
    }
    container.frame = NSRect(x: 0, y: 0, width: x, height: 20)
    return container
}

func makeKeyComboView(_ keys: [String]) -> NSView {
    let container = NSView()
    var x: CGFloat = 0
    for (i, key) in keys.enumerated() {
        let badge = makeKeyBadge(key)
        badge.frame.origin = NSPoint(x: x, y: 0)
        container.addSubview(badge)
        x += badge.frame.width + 2
        if i < keys.count - 1 {
            let plus = NSTextField(labelWithString: "+")
            plus.font = NSFont.monospacedSystemFont(ofSize: 10, weight: .regular)
            plus.textColor = Theme.textMuted
            plus.sizeToFit()
            plus.frame.origin = NSPoint(x: x, y: 2)
            container.addSubview(plus)
            x += plus.frame.width + 2
        }
    }
    container.frame = NSRect(x: 0, y: 0, width: x, height: 20)
    return container
}

// MARK: - Mode Badge
func modeLabel(_ mode: String) -> NSTextField {
    let modeMap = ["n":"NOR","i":"INS","v":"VIS","x":"VIS","t":"TER","c":"CMD","s":"SEL"]
    let colorMap: [String: NSColor] = [
        "n":Theme.blue,"i":Theme.green,"v":Theme.purple,"x":Theme.purple,
        "t":Theme.orange,"c":Theme.yellow,"s":Theme.blue
    ]

    let modes = mode.split(separator: ",").map(String.init)
    let text = modes.map { modeMap[$0.trimmingCharacters(in: .whitespaces)] ?? $0.uppercased() }.joined(separator: "/")
    let color = modes.count > 1 ? Theme.cyan : (colorMap[modes[0].trimmingCharacters(in: .whitespaces)] ?? Theme.blue)

    let label = NSTextField(labelWithString: text)
    label.font = NSFont.monospacedSystemFont(ofSize: 9, weight: .bold)
    label.textColor = color
    label.backgroundColor = color.withAlphaComponent(0.15)
    label.drawsBackground = true
    label.isBezeled = false
    label.isEditable = false
    label.alignment = .center
    label.wantsLayer = true
    label.layer?.cornerRadius = 3
    label.layer?.masksToBounds = true
    let sz = label.intrinsicContentSize
    label.frame = NSRect(x: 0, y: 0, width: max(sz.width + 10, 40), height: sz.height + 2)
    return label
}

// MARK: - Source Badge
func sourceBadge(_ source: String) -> NSTextField {
    let nameMap = ["custom":"Custom","lazyvim":"LazyVim","plugin":"Plugin"]
    let colorMap: [String: NSColor] = ["custom":Theme.pink,"lazyvim":Theme.purple,"plugin":Theme.green]
    let color = colorMap[source] ?? Theme.textMuted
    let label = NSTextField(labelWithString: nameMap[source] ?? source)
    label.font = NSFont.monospacedSystemFont(ofSize: 9, weight: .medium)
    label.textColor = color
    label.backgroundColor = color.withAlphaComponent(0.1)
    label.drawsBackground = true
    label.isBezeled = false
    label.isEditable = false
    label.alignment = .center
    label.wantsLayer = true
    label.layer?.cornerRadius = 4
    label.layer?.masksToBounds = true
    let sz = label.intrinsicContentSize
    label.frame = NSRect(x: 0, y: 0, width: sz.width + 12, height: sz.height + 2)
    return label
}

// MARK: - Row Views
class BindingRowView: NSView {
    override func updateTrackingAreas() {
        super.updateTrackingAreas()
        trackingAreas.forEach { removeTrackingArea($0) }
        addTrackingArea(NSTrackingArea(rect: bounds, options: [.mouseEnteredAndExited, .activeAlways], owner: self))
    }
    override func mouseEntered(with event: NSEvent) { layer?.backgroundColor = Theme.bgHover.cgColor }
    override func mouseExited(with event: NSEvent) { layer?.backgroundColor = NSColor.clear.cgColor }
}

// MARK: - AutoLayout helper
extension NSView {
    func pinToSuperview(top: CGFloat? = nil, leading: CGFloat? = nil, trailing: CGFloat? = nil, bottom: CGFloat? = nil) {
        guard let sv = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        if let t = top { topAnchor.constraint(equalTo: sv.topAnchor, constant: t).isActive = true }
        if let l = leading { leadingAnchor.constraint(equalTo: sv.leadingAnchor, constant: l).isActive = true }
        if let r = trailing { trailingAnchor.constraint(equalTo: sv.trailingAnchor, constant: -r).isActive = true }
        if let b = bottom { bottomAnchor.constraint(equalTo: sv.bottomAnchor, constant: -b).isActive = true }
    }
    func pinHeight(_ h: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: h).isActive = true
    }
}

// MARK: - ScrollView Content Builder
class ContentBuilder {
    static func buildNvimContent(filter: String, query: String, width: CGFloat) -> NSView {
        let container = FlippedView()
        var y: CGFloat = 0
        let w = max(width - 40, 400)

        let filtered = nvimBindings.filter { b in
            let catMatch = filter == "all" || b.category == filter
            let queryMatch = query.isEmpty ||
                b.keys.lowercased().contains(query) ||
                b.desc.lowercased().contains(query) ||
                b.category.lowercased().contains(query) ||
                b.source.lowercased().contains(query)
            return catMatch && queryMatch
        }

        let grouped = Dictionary(grouping: filtered) { $0.category }

        for cat in nvimCategories {
            guard let items = grouped[cat.id], !items.isEmpty else { continue }
            let header = makeSectionHeader(icon: cat.icon, title: cat.title, count: items.count, color: Theme.pink, width: w)
            header.frame.origin = NSPoint(x: 20, y: y)
            container.addSubview(header)
            y += header.frame.height + 8

            for item in items {
                let row = makeNvimRow(item, width: w)
                row.frame.origin = NSPoint(x: 20, y: y)
                container.addSubview(row)
                y += row.frame.height + 2
            }
            y += 16
        }

        if filtered.isEmpty {
            let empty = NSTextField(labelWithString: "No keybindings found.")
            empty.font = NSFont.monospacedSystemFont(ofSize: 13, weight: .regular)
            empty.textColor = Theme.textMuted
            empty.alignment = .center
            empty.frame = NSRect(x: 20, y: y, width: w, height: 40)
            container.addSubview(empty)
            y += 50
        }

        container.frame = NSRect(x: 0, y: 0, width: w + 40, height: y + 20)
        return container
    }

    static func buildWezTermContent(filter: String, query: String, width: CGFloat) -> NSView {
        let container = FlippedView()
        var y: CGFloat = 0
        let w = max(width - 40, 400)

        let filteredKeys = weztermKeys.filter { k in
            let catMatch = filter == "all" || filter == "keys" || k.category == filter
            let queryMatch = query.isEmpty ||
                k.keys.joined(separator: " ").lowercased().contains(query) ||
                k.desc.lowercased().contains(query)
            return catMatch && queryMatch
        }

        let keyGrouped = Dictionary(grouping: filteredKeys) { $0.category }
        for cat in weztermKeyCats {
            guard let items = keyGrouped[cat.id], !items.isEmpty else { continue }
            let header = makeSectionHeader(icon: "\u{2328}", title: cat.title, count: items.count, color: Theme.purple, width: w)
            header.frame.origin = NSPoint(x: 20, y: y)
            container.addSubview(header)
            y += header.frame.height + 8

            for item in items {
                let row = makeWezTermKeyRow(item, width: w)
                row.frame.origin = NSPoint(x: 20, y: y)
                container.addSubview(row)
                y += row.frame.height + 2
            }
            y += 16
        }

        let filteredSettings = weztermSettings.filter { s in
            let catMatch = filter == "all" || s.category == filter
            let queryMatch = query.isEmpty ||
                s.key.lowercased().contains(query) ||
                s.value.lowercased().contains(query) ||
                s.desc.lowercased().contains(query)
            return catMatch && queryMatch
        }

        let setGrouped = Dictionary(grouping: filteredSettings) { $0.category }
        for cat in weztermSettingCats {
            guard let items = setGrouped[cat.id], !items.isEmpty else { continue }
            let header = makeSectionHeader(icon: "\u{2699}", title: cat.title, count: items.count, color: Theme.purple, width: w)
            header.frame.origin = NSPoint(x: 20, y: y)
            container.addSubview(header)
            y += header.frame.height + 8

            for item in items {
                let row = makeSettingRow(item, width: w)
                row.frame.origin = NSPoint(x: 20, y: y)
                container.addSubview(row)
                y += row.frame.height + 2
            }
            y += 16
        }

        if filteredKeys.isEmpty && filteredSettings.isEmpty {
            let empty = NSTextField(labelWithString: "No items found.")
            empty.font = NSFont.monospacedSystemFont(ofSize: 13, weight: .regular)
            empty.textColor = Theme.textMuted
            empty.alignment = .center
            empty.frame = NSRect(x: 20, y: y, width: w, height: 40)
            container.addSubview(empty)
            y += 50
        }

        container.frame = NSRect(x: 0, y: 0, width: w + 40, height: y + 20)
        return container
    }

    static func buildASContent(filter: String, query: String, width: CGFloat) -> NSView {
        let container = FlippedView()
        var y: CGFloat = 0
        let w = max(width - 40, 400)

        let filteredKeys = asKeys.filter { k in
            let catMatch = filter == "all" || k.category == filter
            let queryMatch = query.isEmpty ||
                k.keys.joined(separator: " ").lowercased().contains(query) ||
                k.desc.lowercased().contains(query)
            return catMatch && queryMatch
        }

        let keyGrouped = Dictionary(grouping: filteredKeys) { $0.category }
        for cat in asKeyCats {
            guard let items = keyGrouped[cat.id], !items.isEmpty else { continue }
            let header = makeSectionHeader(icon: "\u{2328}", title: cat.title, count: items.count, color: Theme.green, width: w)
            header.frame.origin = NSPoint(x: 20, y: y)
            container.addSubview(header)
            y += header.frame.height + 8

            for item in items {
                let row = makeASKeyRow(item, width: w)
                row.frame.origin = NSPoint(x: 20, y: y)
                container.addSubview(row)
                y += row.frame.height + 2
            }
            y += 16
        }

        let filteredSettings = asSettings.filter { s in
            let catMatch = filter == "all" || filter == "settings" || s.category == filter
            let queryMatch = query.isEmpty ||
                s.key.lowercased().contains(query) ||
                s.value.lowercased().contains(query) ||
                s.desc.lowercased().contains(query)
            return catMatch && queryMatch
        }

        let setGrouped = Dictionary(grouping: filteredSettings) { $0.category }
        for cat in asSettingCats {
            guard let items = setGrouped[cat.id], !items.isEmpty else { continue }
            let header = makeSectionHeader(icon: "\u{2699}", title: cat.title, count: items.count, color: Theme.green, width: w)
            header.frame.origin = NSPoint(x: 20, y: y)
            container.addSubview(header)
            y += header.frame.height + 8

            for item in items {
                let row = makeSettingRow(item, width: w)
                row.frame.origin = NSPoint(x: 20, y: y)
                container.addSubview(row)
                y += row.frame.height + 2
            }
            y += 16
        }

        // Window rules
        let showRules = (filter == "all" || filter == "rules") && (query.isEmpty ||
            asWindowRules.contains { $0.app.lowercased().contains(query) || $0.layout.lowercased().contains(query) })
        if showRules && !asWindowRules.isEmpty {
            let filteredRules = asWindowRules.filter { r in
                query.isEmpty || r.app.lowercased().contains(query) || r.layout.lowercased().contains(query)
            }
            if !filteredRules.isEmpty {
                let header = makeSectionHeader(icon: "\u{1F4CB}", title: "Window Rules", count: filteredRules.count, color: Theme.green, width: w)
                header.frame.origin = NSPoint(x: 20, y: y)
                container.addSubview(header)
                y += header.frame.height + 8

                for rule in filteredRules {
                    let row = makeWindowRuleRow(app: rule.app, layout: rule.layout, width: w)
                    row.frame.origin = NSPoint(x: 20, y: y)
                    container.addSubview(row)
                    y += row.frame.height + 2
                }
                y += 16
            }
        }

        if filteredKeys.isEmpty && filteredSettings.isEmpty {
            let empty = NSTextField(labelWithString: "No items found.")
            empty.font = NSFont.monospacedSystemFont(ofSize: 13, weight: .regular)
            empty.textColor = Theme.textMuted
            empty.alignment = .center
            empty.frame = NSRect(x: 20, y: y, width: w, height: 40)
            container.addSubview(empty)
            y += 50
        }

        container.frame = NSRect(x: 0, y: 0, width: w + 40, height: y + 20)
        return container
    }

    static func buildHSContent(filter: String, query: String, width: CGFloat) -> NSView {
        let container = FlippedView()
        var y: CGFloat = 0
        let w = max(width - 40, 400)

        let filteredKeys = hsKeys.filter { k in
            let catMatch = filter == "all" || k.category == filter
            let queryMatch = query.isEmpty ||
                k.keys.joined(separator: " ").lowercased().contains(query) ||
                k.desc.lowercased().contains(query)
            return catMatch && queryMatch
        }

        let keyGrouped = Dictionary(grouping: filteredKeys) { $0.category }
        for cat in hsKeyCats {
            guard let items = keyGrouped[cat.id], !items.isEmpty else { continue }
            let header = makeSectionHeader(icon: "\u{2328}", title: cat.title, count: items.count, color: Theme.blue, width: w)
            header.frame.origin = NSPoint(x: 20, y: y)
            container.addSubview(header)
            y += header.frame.height + 8

            for item in items {
                let row = makeHSKeyRow(item, width: w)
                row.frame.origin = NSPoint(x: 20, y: y)
                container.addSubview(row)
                y += row.frame.height + 2
            }
            y += 16
        }

        let showModules = (filter == "all" || filter == "modules")
        let filteredModules = showModules ? hsModules.filter { m in
            query.isEmpty || m.name.lowercased().contains(query) || m.desc.lowercased().contains(query)
        } : []

        if !filteredModules.isEmpty {
            let header = makeSectionHeader(icon: "\u{1F4E6}", title: "Modules", count: filteredModules.count, color: Theme.blue, width: w)
            header.frame.origin = NSPoint(x: 20, y: y)
            container.addSubview(header)
            y += header.frame.height + 8

            for mod in filteredModules {
                let row = makeModuleRow(mod, width: w)
                row.frame.origin = NSPoint(x: 20, y: y)
                container.addSubview(row)
                y += row.frame.height + 2
            }
            y += 16
        }

        if filteredKeys.isEmpty && filteredModules.isEmpty {
            let empty = NSTextField(labelWithString: "No items found.")
            empty.font = NSFont.monospacedSystemFont(ofSize: 13, weight: .regular)
            empty.textColor = Theme.textMuted
            empty.alignment = .center
            empty.frame = NSRect(x: 20, y: y, width: w, height: 40)
            container.addSubview(empty)
            y += 50
        }

        container.frame = NSRect(x: 0, y: 0, width: w + 40, height: y + 20)
        return container
    }

    // MARK: - Row builders
    static func makeSectionHeader(icon: String, title: String, count: Int, color: NSColor, width: CGFloat) -> NSView {
        let view = NSView(frame: NSRect(x: 0, y: 0, width: width, height: 28))
        view.wantsLayer = true

        let iconLabel = NSTextField(labelWithString: icon)
        iconLabel.font = NSFont.systemFont(ofSize: 13)
        iconLabel.sizeToFit()
        iconLabel.frame.origin = NSPoint(x: 8, y: 4)
        view.addSubview(iconLabel)

        let titleLabel = NSTextField(labelWithString: title)
        titleLabel.font = NSFont.monospacedSystemFont(ofSize: 13, weight: .bold)
        titleLabel.textColor = color
        titleLabel.sizeToFit()
        titleLabel.frame.origin = NSPoint(x: 30, y: 4)
        view.addSubview(titleLabel)

        let countLabel = NSTextField(labelWithString: "\(count)")
        countLabel.font = NSFont.monospacedSystemFont(ofSize: 10, weight: .regular)
        countLabel.textColor = Theme.textMuted
        countLabel.backgroundColor = Theme.bgHover
        countLabel.drawsBackground = true
        countLabel.wantsLayer = true
        countLabel.layer?.cornerRadius = 8
        countLabel.layer?.masksToBounds = true
        countLabel.alignment = .center
        countLabel.sizeToFit()
        countLabel.frame = NSRect(x: titleLabel.frame.maxX + 8, y: 5, width: countLabel.intrinsicContentSize.width + 12, height: 18)
        view.addSubview(countLabel)

        let line = NSView(frame: NSRect(x: 0, y: 0, width: width, height: 2))
        line.wantsLayer = true
        line.layer?.backgroundColor = Theme.border.cgColor
        view.addSubview(line)

        return view
    }

    static func makeNvimRow(_ b: KeyBinding, width: CGFloat) -> NSView {
        let row = BindingRowView(frame: NSRect(x: 0, y: 0, width: width, height: 28))
        row.wantsLayer = true
        row.layer?.cornerRadius = 4

        let keysView = makeKeysView(b.keys)
        keysView.frame.origin = NSPoint(x: 10, y: 4)
        keysView.frame.size.width = 170
        row.addSubview(keysView)

        let mode = modeLabel(b.mode)
        mode.frame.origin = NSPoint(x: 190, y: 5)
        row.addSubview(mode)

        let desc = NSTextField(labelWithString: b.desc)
        desc.font = NSFont.monospacedSystemFont(ofSize: 12, weight: .regular)
        desc.textColor = Theme.textSub
        desc.frame = NSRect(x: 250, y: 5, width: max(width - 340, 100), height: 18)
        row.addSubview(desc)

        let src = sourceBadge(b.source)
        src.frame.origin = NSPoint(x: max(width - 80, 260), y: 5)
        row.addSubview(src)

        return row
    }

    static func makeWezTermKeyRow(_ k: WezTermKey, width: CGFloat) -> NSView {
        let row = BindingRowView(frame: NSRect(x: 0, y: 0, width: width, height: 28))
        row.wantsLayer = true
        row.layer?.cornerRadius = 4

        let keysView = makeKeyComboView(k.keys)
        keysView.frame.origin = NSPoint(x: 10, y: 4)
        row.addSubview(keysView)

        let desc = NSTextField(labelWithString: k.desc)
        desc.font = NSFont.monospacedSystemFont(ofSize: 12, weight: .regular)
        desc.textColor = Theme.textSub
        desc.frame = NSRect(x: 240, y: 5, width: max(width - 260, 100), height: 18)
        row.addSubview(desc)

        return row
    }

    static func makeASKeyRow(_ k: ASKey, width: CGFloat) -> NSView {
        let row = BindingRowView(frame: NSRect(x: 0, y: 0, width: width, height: 28))
        row.wantsLayer = true
        row.layer?.cornerRadius = 4

        let keysView = makeKeyComboView(k.keys)
        keysView.frame.origin = NSPoint(x: 10, y: 4)
        row.addSubview(keysView)

        let desc = NSTextField(labelWithString: k.desc)
        desc.font = NSFont.monospacedSystemFont(ofSize: 12, weight: .regular)
        desc.textColor = Theme.textSub
        desc.frame = NSRect(x: 240, y: 5, width: max(width - 260, 100), height: 18)
        row.addSubview(desc)

        return row
    }

    static func makeWindowRuleRow(app: String, layout: String, width: CGFloat) -> NSView {
        let row = BindingRowView(frame: NSRect(x: 0, y: 0, width: width, height: 28))
        row.wantsLayer = true
        row.layer?.cornerRadius = 4

        let appLabel = NSTextField(labelWithString: app)
        appLabel.font = NSFont.monospacedSystemFont(ofSize: 12, weight: .semibold)
        appLabel.textColor = Theme.cyan
        appLabel.frame = NSRect(x: 10, y: 5, width: 260, height: 18)
        row.addSubview(appLabel)

        let layoutLabel = NSTextField(labelWithString: layout)
        layoutLabel.font = NSFont.monospacedSystemFont(ofSize: 12, weight: .regular)
        layoutLabel.textColor = Theme.orange
        layoutLabel.frame = NSRect(x: 280, y: 5, width: max(width - 300, 100), height: 18)
        row.addSubview(layoutLabel)

        return row
    }

    static func makeHSKeyRow(_ k: HSKey, width: CGFloat) -> NSView {
        let row = BindingRowView(frame: NSRect(x: 0, y: 0, width: width, height: 28))
        row.wantsLayer = true
        row.layer?.cornerRadius = 4

        let keysView = makeKeyComboView(k.keys)
        keysView.frame.origin = NSPoint(x: 10, y: 4)
        row.addSubview(keysView)

        let desc = NSTextField(labelWithString: k.desc)
        desc.font = NSFont.monospacedSystemFont(ofSize: 12, weight: .regular)
        desc.textColor = Theme.textSub
        desc.frame = NSRect(x: 240, y: 5, width: max(width - 260, 100), height: 18)
        row.addSubview(desc)

        return row
    }

    static func makeSettingRow(_ s: Setting, width: CGFloat) -> NSView {
        let row = BindingRowView(frame: NSRect(x: 0, y: 0, width: width, height: 28))
        row.wantsLayer = true
        row.layer?.cornerRadius = 4

        let key = NSTextField(labelWithString: s.key)
        key.font = NSFont.monospacedSystemFont(ofSize: 12, weight: .semibold)
        key.textColor = Theme.cyan
        key.frame = NSRect(x: 10, y: 5, width: 260, height: 18)
        row.addSubview(key)

        let val = NSTextField(labelWithString: s.value)
        val.font = NSFont.monospacedSystemFont(ofSize: 12, weight: .regular)
        val.textColor = Theme.pink
        val.frame = NSRect(x: 280, y: 5, width: 200, height: 18)
        row.addSubview(val)

        let desc = NSTextField(labelWithString: s.desc)
        desc.font = NSFont.monospacedSystemFont(ofSize: 11, weight: .regular)
        desc.textColor = Theme.textMuted
        desc.frame = NSRect(x: 490, y: 5, width: max(width - 510, 60), height: 18)
        row.addSubview(desc)

        return row
    }

    static func makeModuleRow(_ m: ModuleInfo, width: CGFloat) -> NSView {
        let row = BindingRowView(frame: NSRect(x: 0, y: 0, width: width, height: 28))
        row.wantsLayer = true
        row.layer?.cornerRadius = 4

        let name = NSTextField(labelWithString: m.name)
        name.font = NSFont.monospacedSystemFont(ofSize: 12, weight: .semibold)
        name.textColor = Theme.cyan
        name.frame = NSRect(x: 10, y: 5, width: 200, height: 18)
        row.addSubview(name)

        let desc = NSTextField(labelWithString: m.desc)
        desc.font = NSFont.monospacedSystemFont(ofSize: 12, weight: .regular)
        desc.textColor = Theme.textSub
        desc.frame = NSRect(x: 220, y: 5, width: max(width - 240, 100), height: 18)
        row.addSubview(desc)

        return row
    }
}

// MARK: - Filter Button
class FilterButton: NSButton {
    var filterId: String = ""
    var isActive: Bool = false {
        didSet { updateAppearance() }
    }
    var accentColor: NSColor = Theme.blue

    func updateAppearance() {
        wantsLayer = true
        layer?.cornerRadius = 6
        layer?.borderWidth = 1
        if isActive {
            layer?.backgroundColor = accentColor.cgColor
            layer?.borderColor = accentColor.cgColor
            attributedTitle = NSAttributedString(string: title, attributes: [
                .font: NSFont.monospacedSystemFont(ofSize: 11, weight: .semibold),
                .foregroundColor: Theme.bg
            ])
        } else {
            layer?.backgroundColor = NSColor.clear.cgColor
            layer?.borderColor = Theme.border.cgColor
            attributedTitle = NSAttributedString(string: title, attributes: [
                .font: NSFont.monospacedSystemFont(ofSize: 11, weight: .regular),
                .foregroundColor: Theme.textSub
            ])
        }
    }
}

// MARK: - Main Window Controller
class MagicBoardWindowController: NSObject, NSSearchFieldDelegate, NSWindowDelegate {
    var window: NSWindow!
    var tabButtons: [NSButton] = []
    var filterButtons: [FilterButton] = []
    var searchField: NSSearchField!
    var scrollView: NSScrollView!
    var countLabel: NSTextField!
    var filterBar: NSView!

    var currentTab: Tab = .neovim
    var currentFilter: String = "all"
    var currentQuery: String = ""

    let filtersByTab: [Tab: [(id: String, title: String)]] = [
        .neovim: [("all","All")] + nvimCategories.map { ($0.id, $0.title) },
        .wezterm: [("all","All"),("keys","Keybindings")] + weztermSettingCats.map { ($0.id, $0.title) },
        .aerospace: [("all","All")] + asKeyCats.map { ($0.id, $0.title) } + [("settings","Settings"),("rules","Window Rules")],
        .hammerspoon: [("all","All")] + hsKeyCats.map { ($0.id, $0.title) } + [("modules","Modules")],
    ]

    func showWindow() {
        let screen = NSScreen.main!.visibleFrame
        let width: CGFloat = 1100
        let height: CGFloat = 750
        let x = screen.origin.x + (screen.width - width) / 2
        let y = screen.origin.y + (screen.height - height) / 2

        window = NSWindow(
            contentRect: NSRect(x: x, y: y, width: width, height: height),
            styleMask: [.titled, .closable, .resizable, .miniaturizable, .fullSizeContentView],
            backing: .buffered,
            defer: false
        )
        window.title = "MagicBoard"
        window.titlebarAppearsTransparent = true
        window.titleVisibility = .hidden
        window.backgroundColor = Theme.bg
        window.isReleasedWhenClosed = false
        window.level = .floating
        window.isMovableByWindowBackground = true
        window.minSize = NSSize(width: 600, height: 400)
        window.delegate = self

        let content = window.contentView!
        content.wantsLayer = true
        content.layer?.backgroundColor = Theme.bg.cgColor

        // MARK: Tab bar (AutoLayout)
        let tabBar = NSView()
        tabBar.wantsLayer = true
        tabBar.layer?.backgroundColor = Theme.bg2.cgColor
        content.addSubview(tabBar)
        tabBar.pinToSuperview(top: 0, leading: 0, trailing: 0)
        tabBar.pinHeight(50)

        let titleLabel = NSTextField(labelWithString: "MagicBoard")
        titleLabel.font = NSFont.monospacedSystemFont(ofSize: 14, weight: .bold)
        titleLabel.textColor = Theme.text
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        tabBar.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor, constant: 80),
            titleLabel.centerYAnchor.constraint(equalTo: tabBar.centerYAnchor),
        ])

        let tabStack = NSStackView()
        tabStack.orientation = .horizontal
        tabStack.spacing = 8
        tabStack.translatesAutoresizingMaskIntoConstraints = false
        tabBar.addSubview(tabStack)
        NSLayoutConstraint.activate([
            tabStack.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 24),
            tabStack.centerYAnchor.constraint(equalTo: tabBar.centerYAnchor),
        ])

        for tab in Tab.allCases {
            let btn = NSButton(frame: .zero)
            btn.title = "\(tab.icon) \(tab.title)"
            btn.bezelStyle = .recessed
            btn.isBordered = false
            btn.wantsLayer = true
            btn.layer?.cornerRadius = 6
            btn.tag = tab.rawValue
            btn.target = self
            btn.action = #selector(tabClicked(_:))
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.widthAnchor.constraint(equalToConstant: 120).isActive = true
            btn.heightAnchor.constraint(equalToConstant: 30).isActive = true
            tabButtons.append(btn)
            tabStack.addArrangedSubview(btn)
        }

        // Border under tabs
        let tabBorder = NSView()
        tabBorder.wantsLayer = true
        tabBorder.layer?.backgroundColor = Theme.border.cgColor
        content.addSubview(tabBorder)
        tabBorder.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tabBorder.topAnchor.constraint(equalTo: tabBar.bottomAnchor),
            tabBorder.leadingAnchor.constraint(equalTo: content.leadingAnchor),
            tabBorder.trailingAnchor.constraint(equalTo: content.trailingAnchor),
            tabBorder.heightAnchor.constraint(equalToConstant: 1),
        ])

        // MARK: Search bar (AutoLayout)
        let searchBar = NSView()
        searchBar.wantsLayer = true
        searchBar.layer?.backgroundColor = Theme.bg2.cgColor
        content.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: tabBorder.bottomAnchor),
            searchBar.leadingAnchor.constraint(equalTo: content.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: content.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 44),
        ])

        searchField = NSSearchField()
        searchField.placeholderString = "Search...  ( / to focus, Esc to clear )"
        searchField.font = NSFont.monospacedSystemFont(ofSize: 12, weight: .regular)
        searchField.focusRingType = .none
        searchField.delegate = self
        searchField.appearance = NSAppearance(named: .darkAqua)
        searchField.translatesAutoresizingMaskIntoConstraints = false
        searchBar.addSubview(searchField)

        countLabel = NSTextField(labelWithString: "")
        countLabel.font = NSFont.monospacedSystemFont(ofSize: 11, weight: .regular)
        countLabel.textColor = Theme.textMuted
        countLabel.alignment = .right
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.setContentHuggingPriority(.required, for: .horizontal)
        searchBar.addSubview(countLabel)

        NSLayoutConstraint.activate([
            searchField.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor, constant: 20),
            searchField.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            searchField.trailingAnchor.constraint(equalTo: countLabel.leadingAnchor, constant: -12),
            searchField.heightAnchor.constraint(equalToConstant: 28),
            countLabel.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: -20),
            countLabel.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            countLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 120),
        ])

        let searchBorder = NSView()
        searchBorder.wantsLayer = true
        searchBorder.layer?.backgroundColor = Theme.border.cgColor
        content.addSubview(searchBorder)
        searchBorder.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBorder.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            searchBorder.leadingAnchor.constraint(equalTo: content.leadingAnchor),
            searchBorder.trailingAnchor.constraint(equalTo: content.trailingAnchor),
            searchBorder.heightAnchor.constraint(equalToConstant: 1),
        ])

        // MARK: Filter bar (AutoLayout)
        filterBar = NSView()
        filterBar.wantsLayer = true
        filterBar.layer?.backgroundColor = Theme.bg2.cgColor
        content.addSubview(filterBar)
        filterBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            filterBar.topAnchor.constraint(equalTo: searchBorder.bottomAnchor),
            filterBar.leadingAnchor.constraint(equalTo: content.leadingAnchor),
            filterBar.trailingAnchor.constraint(equalTo: content.trailingAnchor),
            filterBar.heightAnchor.constraint(equalToConstant: 40),
        ])

        let filterBorder = NSView()
        filterBorder.wantsLayer = true
        filterBorder.layer?.backgroundColor = Theme.border.cgColor
        content.addSubview(filterBorder)
        filterBorder.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            filterBorder.topAnchor.constraint(equalTo: filterBar.bottomAnchor),
            filterBorder.leadingAnchor.constraint(equalTo: content.leadingAnchor),
            filterBorder.trailingAnchor.constraint(equalTo: content.trailingAnchor),
            filterBorder.heightAnchor.constraint(equalToConstant: 1),
        ])

        // MARK: Scroll view (AutoLayout)
        scrollView = NSScrollView()
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = false
        scrollView.drawsBackground = true
        scrollView.backgroundColor = Theme.bg
        scrollView.scrollerStyle = .overlay
        scrollView.contentView.drawsBackground = true
        scrollView.contentView.backgroundColor = Theme.bg
        content.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: filterBorder.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: content.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: content.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: content.bottomAnchor),
        ])

        // Keyboard handler
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) { [weak self] event in
            guard let self = self else { return event }
            if event.keyCode == 53 { // Esc
                if !self.currentQuery.isEmpty {
                    self.searchField.stringValue = ""
                    self.currentQuery = ""
                    self.rebuildContent()
                    return nil
                }
                self.window.close()
                NSApp.terminate(nil)
                return nil
            }
            if event.characters == "/" && !(self.searchField.currentEditor() != nil) {
                self.window.makeFirstResponder(self.searchField)
                return nil
            }
            if event.modifierFlags.contains(.command) {
                if let c = event.characters, let n = Int(c), n >= 1 && n <= 4 {
                    self.switchTab(Tab(rawValue: n - 1) ?? .neovim)
                    return nil
                }
            }
            return event
        }

        updateTabAppearance()
        buildFilterButtons()
        rebuildContent()

        window.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }

    // NSWindowDelegate - リサイズ時にコンテンツを再構築
    func windowDidResize(_ notification: Notification) {
        rebuildContent()
    }

    @objc func tabClicked(_ sender: NSButton) {
        switchTab(Tab(rawValue: sender.tag) ?? .neovim)
    }

    func switchTab(_ tab: Tab) {
        currentTab = tab
        currentFilter = "all"
        currentQuery = ""
        searchField.stringValue = ""
        updateTabAppearance()
        buildFilterButtons()
        rebuildContent()
    }

    func updateTabAppearance() {
        for btn in tabButtons {
            let tab = Tab(rawValue: btn.tag)!
            if tab == currentTab {
                btn.layer?.backgroundColor = tab.color.withAlphaComponent(0.2).cgColor
                btn.attributedTitle = NSAttributedString(string: btn.title, attributes: [
                    .font: NSFont.monospacedSystemFont(ofSize: 12, weight: .bold),
                    .foregroundColor: tab.color
                ])
            } else {
                btn.layer?.backgroundColor = NSColor.clear.cgColor
                btn.attributedTitle = NSAttributedString(string: btn.title, attributes: [
                    .font: NSFont.monospacedSystemFont(ofSize: 12, weight: .regular),
                    .foregroundColor: Theme.textMuted
                ])
            }
        }
    }

    func buildFilterButtons() {
        filterButtons.forEach { $0.removeFromSuperview() }
        filterButtons.removeAll()

        let filters = filtersByTab[currentTab] ?? [("all","All")]
        var x: CGFloat = 12
        for f in filters {
            let btn = FilterButton(frame: NSRect(x: x, y: 6, width: 0, height: 28))
            btn.title = f.title
            btn.filterId = f.id
            btn.accentColor = currentTab.color
            btn.isBordered = false
            btn.target = self
            btn.action = #selector(filterClicked(_:))
            btn.isActive = (f.id == currentFilter)
            btn.sizeToFit()
            btn.frame.size.width += 16
            btn.frame.size.height = 28
            btn.updateAppearance()
            filterBar.addSubview(btn)
            filterButtons.append(btn)
            x += btn.frame.width + 6
        }
    }

    @objc func filterClicked(_ sender: FilterButton) {
        currentFilter = sender.filterId
        for btn in filterButtons {
            btn.isActive = (btn.filterId == currentFilter)
        }
        rebuildContent()
    }

    func rebuildContent() {
        let scrollWidth = scrollView.frame.width > 0 ? scrollView.frame.width : 1060
        let contentView: NSView
        switch currentTab {
        case .neovim:
            contentView = ContentBuilder.buildNvimContent(filter: currentFilter, query: currentQuery, width: scrollWidth)
        case .wezterm:
            contentView = ContentBuilder.buildWezTermContent(filter: currentFilter, query: currentQuery, width: scrollWidth)
        case .aerospace:
            contentView = ContentBuilder.buildASContent(filter: currentFilter, query: currentQuery, width: scrollWidth)
        case .hammerspoon:
            contentView = ContentBuilder.buildHSContent(filter: currentFilter, query: currentQuery, width: scrollWidth)
        }

        scrollView.documentView = contentView
        scrollView.documentView?.scroll(.zero)

        let count = countItems()
        countLabel.stringValue = "Showing: \(count) items"
    }

    func countItems() -> Int {
        switch currentTab {
        case .neovim:
            return nvimBindings.filter { b in
                let catMatch = currentFilter == "all" || b.category == currentFilter
                let queryMatch = currentQuery.isEmpty ||
                    b.keys.lowercased().contains(currentQuery) ||
                    b.desc.lowercased().contains(currentQuery)
                return catMatch && queryMatch
            }.count
        case .wezterm:
            let kc = weztermKeys.filter { k in
                let catMatch = currentFilter == "all" || currentFilter == "keys" || k.category == currentFilter
                let queryMatch = currentQuery.isEmpty ||
                    k.keys.joined(separator: " ").lowercased().contains(currentQuery) ||
                    k.desc.lowercased().contains(currentQuery)
                return catMatch && queryMatch
            }.count
            let sc = weztermSettings.filter { s in
                let catMatch = currentFilter == "all" || s.category == currentFilter
                let queryMatch = currentQuery.isEmpty ||
                    s.key.lowercased().contains(currentQuery) ||
                    s.value.lowercased().contains(currentQuery) ||
                    s.desc.lowercased().contains(currentQuery)
                return catMatch && queryMatch
            }.count
            return kc + sc
        case .aerospace:
            let kc = asKeys.filter { k in
                let catMatch = currentFilter == "all" || k.category == currentFilter
                let queryMatch = currentQuery.isEmpty ||
                    k.keys.joined(separator: " ").lowercased().contains(currentQuery) ||
                    k.desc.lowercased().contains(currentQuery)
                return catMatch && queryMatch
            }.count
            let sc = asSettings.filter { s in
                let catMatch = currentFilter == "all" || currentFilter == "settings" || s.category == currentFilter
                let queryMatch = currentQuery.isEmpty ||
                    s.key.lowercased().contains(currentQuery) ||
                    s.value.lowercased().contains(currentQuery) ||
                    s.desc.lowercased().contains(currentQuery)
                return catMatch && queryMatch
            }.count
            let rc = (currentFilter == "all" || currentFilter == "rules") ?
                asWindowRules.filter { r in
                    currentQuery.isEmpty ||
                    r.app.lowercased().contains(currentQuery) ||
                    r.layout.lowercased().contains(currentQuery)
                }.count : 0
            return kc + sc + rc
        case .hammerspoon:
            let kc = hsKeys.filter { k in
                let catMatch = currentFilter == "all" || k.category == currentFilter
                let queryMatch = currentQuery.isEmpty ||
                    k.keys.joined(separator: " ").lowercased().contains(currentQuery) ||
                    k.desc.lowercased().contains(currentQuery)
                return catMatch && queryMatch
            }.count
            let mc = (currentFilter == "all" || currentFilter == "modules") ?
                hsModules.filter { m in
                    currentQuery.isEmpty ||
                    m.name.lowercased().contains(currentQuery) ||
                    m.desc.lowercased().contains(currentQuery)
                }.count : 0
            return kc + mc
        }
    }

    func controlTextDidChange(_ obj: Notification) {
        currentQuery = searchField.stringValue.lowercased().trimmingCharacters(in: .whitespaces)
        rebuildContent()
    }
}

// MARK: - Flipped View (for top-to-bottom layout)
class FlippedView: NSView {
    override var isFlipped: Bool { return true }
}

// MARK: - App Delegate
class AppDelegate: NSObject, NSApplicationDelegate {
    let controller = MagicBoardWindowController()

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Set app icon from MagicBoard.icns next to the executable
        let execURL = URL(fileURLWithPath: CommandLine.arguments[0]).deletingLastPathComponent()
        let icnsURL = execURL.appendingPathComponent("MagicBoard.icns")
        if let icon = NSImage(contentsOf: icnsURL) {
            NSApp.applicationIconImage = icon
        }
        controller.showWindow()
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ application: NSApplication) -> Bool {
        return true
    }
}

// MARK: - Main
let app = NSApplication.shared
app.setActivationPolicy(.regular)
let delegate = AppDelegate()
app.delegate = delegate
app.run()
