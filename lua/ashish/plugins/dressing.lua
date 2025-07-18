return
{
  'stevearc/dressing.nvim',
  opts = {
    select = {
      get_config = function(opts)
        if opts.kind == 'codeaction' then
          return {
            backend = 'nui',
            nui = {
              relative = 'cursor',
              max_width = 40,
            }
          }
        end
      end
    }
  },
  lazy = false,
  priority = 800
}
