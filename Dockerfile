FROM yetone/cosmos-nvim-base

RUN wget https://github.com/cli/cli/releases/download/v2.4.0/gh_2.4.0_linux_amd64.deb && dpkg -i gh*.deb && rm gh*.deb
COPY . /root/.config/nvim
RUN COSMOS_BUILD_IMG=1 nvim --headless "+Lazy! sync" +qa
RUN nvim --headless -c 'lua require("nvim-treesitter.install").update({ with_sync = true }); vim.cmd("quitall")'

