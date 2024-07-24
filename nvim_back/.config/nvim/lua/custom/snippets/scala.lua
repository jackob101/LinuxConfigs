require("luasnip.session.snippet_collection").clear_snippets("scala")

local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local t = ls.text_node
local postfix = require("luasnip.extras.postfix").postfix
local treesitter_postfix = require("luasnip.extras.treesitter_postfix").treesitter_postfix

local fmt = require("luasnip.extras.fmt").fmt

function all_trim(s)
	return s:match("^%s*(.*)"):match("(.-)%s*$")
end

ls.add_snippets("scala", {
	postfix(".print", {
		f(function(_, parent)
			return "println(" .. parent.snippet.env.POSTFIX_MATCH .. ")"
		end, {}),
	}),
	treesitter_postfix({
		trig = ".val",
		matchTSNode = {
			query = [[
            [
              (call_expression)
              (string)
              (integer_literal)
            ] @prefix
        ]],
			query_lang = "scala",
		},
	}, {
		t("val "),
		i(1),
		f(function(_, parent)
			local content = ""
			for _, value in ipairs(parent.snippet.env.LS_TSMATCH) do
				content = content .. all_trim(value)
			end
			return " = " .. content
		end),
		i(0),
	}),
	s("@main", {
		t("@main def main() = {}"),
	}),
	s("def", {
		t("def "),
		i(1),
		t("("),
		i(2),
		t("): "),
		i(3),
		t(" = { "),
		i(0),
		t(" }"),
	}),
	s(
		{ trig = "a%d", regTrig = true },
		f(function(_, snip)
			return "Triggered with text: " .. snip.trigger .. "."
		end, {})
	),
})
