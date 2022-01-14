FROM yetone/cosmos-nvim-base

RUN wget https://github.com/cli/cli/releases/download/v2.4.0/gh_2.4.0_linux_amd64.deb && dpkg -i gh*.deb && rm gh*.deb
RUN git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
COPY . /root/.config/nvim
RUN nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
RUN nvim --headless -c 'lua require("nvim-lsp-installer").install_sync({ "sumneko_lua", "pyright", "gopls" }); vim.cmd("quitall")'
RUN nvim --headless -c 'lua require("nvim-treesitter.install").update({ with_sync = true }); vim.cmd("quitall")'

