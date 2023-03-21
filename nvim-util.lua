-- WIP
-- utlity functions
-- toggle formatting
function disable_formatting(client, bufnr)
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false
    common_on_attach(client, bufnr)
end

function enable_formatting(client, bufnr)
    client.server_capabilities.document_formatting = true
    client.server_capabilities.document_range_formatting = true
    common_on_attach(client, bufnr)
end
