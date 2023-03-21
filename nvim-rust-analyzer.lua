---------------------------------------------------------------------------------
-- rust_analyzer
-- see -- rust-tools
-- This code is not included in init
---------------------------------------------------------------------------------
-- 📌 run this in a context that exposes
--    on_attach and capabilities
---------------------------------------------------------------------------------
require("lspconfig").rust_analyzer.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    -- settings see rust-tools
})
