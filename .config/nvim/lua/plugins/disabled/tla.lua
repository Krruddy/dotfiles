return {
  "susliko/tla.nvim",
  enabled = false,
  config = function()
    local java_home = vim.env.JAVA_HOME
    local java_executable

    if java_home and java_home ~= "" then
      java_executable = java_home .. "/bin/java"
    end

    java_executable = java_executable or vim.fn.exepath("java")
    if java_executable == "" then
      java_executable = "java"
    end

    require("tla").setup({
      java_executable = java_executable,
    })
  end,
}
