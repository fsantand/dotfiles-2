return {
  'goolord/alpha-nvim',
  config = function ()
    local alpha = require'alpha'
    local theta = require'alpha.themes.theta'
    local dashboard = require'alpha.themes.dashboard'

    theta.buttons.val = {
      { type = "text", val = "Quick links", opts = { hl = "SpecialComment", position = "center" } },
      { type = "padding", val = 1 },
      dashboard.button("e", "  New file", "<cmd>ene<CR>"),
      dashboard.button("SPC p f", "󰈞  Find file"),
      dashboard.button("SPC p s", "󰊄  Live grep"),
      dashboard.button("c", "  Configuration", "<cmd>cd ~/.config/nvim/ <CR>"),
      dashboard.button("u", "  Update plugins", "<cmd>Lazy sync<CR>"),
      dashboard.button("q", "󰅚  Quit", "<cmd>qa<CR>"),
    }

    theta.header.val = {
      [[               ▄▄██████████▄▄             ]],
      [[               ▀▀▀   ██   ▀▀▀             ]],
      [[       ▄██▄   ▄▄████████████▄▄   ▄██▄     ]],
      [[     ▄███▀  ▄████▀▀▀    ▀▀▀████▄  ▀███▄   ]],
      [[    ████▄ ▄███▀              ▀███▄ ▄████  ]],
      [[   ███▀█████▀▄████▄      ▄████▄▀█████▀███ ]],
      [[   ██▀  ███▀ ██████      ██████ ▀███  ▀██ ]],
      [[    ▀  ▄██▀  ▀████▀  ▄▄  ▀████▀  ▀██▄  ▀  ]],
      [[       ███           ▀▀           ███     ]],
      [[       ██████████████████████████████     ]],
      [[   ▄█  ▀██  ███   ██    ██   ███  ██▀  █▄ ]],
      [[   ███  ███ ███   ██    ██   ███▄███  ███ ]],
      [[   ▀██▄████████   ██    ██   ████████▄██▀ ]],
      [[    ▀███▀ ▀████   ██    ██   ████▀ ▀███▀  ]],
      [[     ▀███▄  ▀███████    ███████▀  ▄███▀   ]],
      [[       ▀███    ▀▀██████████▀▀▀   ███▀     ]],
      [[         ▀    ▄▄▄    ██    ▄▄▄    ▀       ]],
      [[               ▀████████████▀             ]],
    }

    alpha.setup(theta.config)
  end
};
