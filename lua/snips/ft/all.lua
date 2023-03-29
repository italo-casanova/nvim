local ls = require "luasnip"
local s = ls.snippet
local f = ls.function_node
local p = require("luasnip.extras").partial

local function bash(_, snip)
  local file = io.popen(snip.trigger, "r")
  local res = {}
  for line in file:lines() do
    table.insert(res, line)
  end
  return res
end

local newline = function(text)
  return t { "", text }
end

local snippets = {
  s({ trig = "ymd", name = "Current date", dscr = "Insert the current date" }, {
    p(os.date, "%Y-%m-%d"),
  }),

  s({ trig = "pwd" }, { f(bash, {}) }),

  s({trig = "head"}, {
          t("#include<bits\\stdc++.h>"),
          newline(""),
          t("#define FIN ios_base::sync_with_stdio(false); cin.tie(nullptr); cout.tie(nullptr)"),
          t("#define ll long lons"),
          newline(""),
          t("using namespace std:"),
          newline(""),
          t("int main(){"),
          newline(""),
          t("\tFIN;"),
          newline(""),
          t("\treturn 0;\n}")

      })
}

return snippets
