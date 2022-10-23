local ls = require("luasnip")

local s = ls.s
local t = ls.text_node
local file_patterns = "*.cpp"

local newline = function(text)
  return t { "", text }
end

ls.add_snippets("all", {
        s("head", {
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
    })
