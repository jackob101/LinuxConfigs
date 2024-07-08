require("luasnip.session.snippet_collection").clear_snippets("go")

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

ls.add_snippets("go", {
	s("if", { t("if "), i(1), t(" {"), i(2), t("}"), i(0) }),
	s("func", { t("func "), i(1), t("("), i(2), t(") "), i(3), t(" { "), i(4), t(" }"), i(0) }),
	s(
		"endpoint",
		fmt(
			[[
	// @summary      Default summary
	// @description  Default description
	// @tags         task
	// @accept       json
	// @produce      json
	// @param        request body string true "Task informations"
	// @success      201 {object} string
	// @failure      400 {object} string
	// @router       /endpoint [post]
	func (ctrl *<>) <>(ctx *gin.Context) {<>}
	]],
			{
				i(1),
				i(2),
				i(3),
			},
			{
				delimiters = "<>",
			}
		)
	),
})
