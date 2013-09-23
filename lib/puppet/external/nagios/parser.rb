#
# DO NOT MODIFY!!!!
# This file is automatically generated by Racc 1.4.9
# from Racc grammer file "".
#

require 'racc/parser.rb'
module Nagios
  class Parser < Racc::Parser

module_eval(<<'...end grammar.ry/module_eval...', 'grammar.ry', 49)
require 'strscan'

class ::Nagios::Parser::SyntaxError < RuntimeError; end

def parse(src)
    if src.respond_to?("force_encoding") then
        src.force_encoding("ASCII-8BIT")
    end
    @ss = StringScanner.new(src)

    # state variables
    @invar = false
    @inobject = false
    @done = false

    @line = 1
    @yydebug = true

    do_parse
end

# The lexer.  Very simple.
def token
    text = @ss.peek(1)
    @line  +=  1  if text == "\n"

    token = if not @inobject
        case
          when (chars = @ss.skip(/[ \t]+/))             # ignore whitespace /\s+/
            ;

          when (text = @ss.scan(/\#.*$/))               # ignore comments
            ;

          when (text = @ss.scan(/;.*$/))               # ignore inline comments
            ;

          when (text = @ss.scan(/\n/))                  # newline
            action { [:RETURN, text] }

          when (text = @ss.scan(/\b(define)\b/))
            action { [:DEFINE, text] }

          when (text = @ss.scan(/[^{ \t\n]+/))
            action { [:NAME, text] }

          when (text = @ss.scan(/\{/))
            @inobject = true
            action { [:LCURLY, text] }

          else
            text = @ss.string[@ss.pos .. -1]
            raise  ScanError, "can not match: '" + text + "'"
        end  # case
    else   # @inobject == true
        if @invar
            case
              when (chars = @ss.skip(/[ \t]+/))             # ignore whitespace /\s+/
                ;

              when (text = @ss.scan(/\#.*$/))               # ignore comments
                ;

              when (text = @ss.scan(/\n/))                  # newline
                action { [:RETURN, text] }

              when (text = @ss.scan(/.+$/))                 # Value of parameter
                @invar = false

                # Special handling of inline comments (;) and escaped semicolons (\;)

                # We split the string on escaped semicolons (\;),
                # Then we rebuild it as long as there are no inline comments (;)
                # We join the rebuilt string with unescaped semicolons (on purpose)
                array = text.split('\;', 0)

                text = ""

                array.each do |elt|

                    # Now we split at inline comments. If we have more than 1 element in the array
                    # it means we have an inline comment, so we are able to stop parsing
                    # However we still want to reconstruct the string with its first part (before the comment)
                    linearray = elt.split(';', 0)

                    # Let's reconstruct the string with a (unescaped) semicolon
                    if text != "" then
                        text += ';'
                    end
                    text += linearray[0]

                    # Now we can stop
                    if linearray.length > 1 then
                        break                                
                    end
                end


                # We strip the text to remove spaces between end of string and beginning of inline comment
                action { [:VALUE, text.strip] }

              else
                text = @ss.string[@ss.pos .. -1]
                raise  ScanError, "can not match: '" + text + "'"
            end  # case
        else              # @invar == false
            case
              when (chars = @ss.skip(/[ \t]+/))             # ignore whitespace /\s+/
                ;

              when (text = @ss.scan(/\#.*$/))               # ignore comments
                ;

              when (text = @ss.scan(/;.*$/))               # ignore inline comments
                ;

              when (text = @ss.scan(/\n/))                  # newline
                action { [:RETURN, text] }

              when (text = @ss.scan(/\}/))
                @inobject = false
                action { [:RCURLY, text] }

              when (not @invar and (text = @ss.scan(/\S+/)))
                @invar = true
                action { [:PARAM, text] }

              else
                text = @ss.string[@ss.pos .. -1]
                raise  ScanError, "can not match: '#{text}'"
            end  # case
        end  # if @invar
    end  # if not @inobject
    token
end

def next_token
    return if @ss.eos?

    # skips empty actions
    until _next_token = token or @ss.eos?; end
    _next_token
end

def yydebug
    1
end

def yywrap
    0
end

def action
    yield
end

def on_error(token, value, vstack )
#    text = @ss.string[@ss.pos .. -1]
    text = @ss.peek(20)
    msg = ""
    unless value.nil?
        msg = "line #{@line}: syntax error at value '#{value}' : #{text}"
    else
        msg = "line #{@line}: syntax error at token '#{token}' : #{text}"
    end
    if @ss.eos?
        msg = "line #{@line}: Unexpected end of file"
    end
    if token == '$end'.intern
        puts "okay, this is silly"
    else
        raise ::Nagios::Parser::SyntaxError, msg
    end
end
...end grammar.ry/module_eval...
##### State transition tables begin ###

racc_action_table = [
     6,     5,     5,    15,    12,    17,    10,     4,     4,     9,
    15,    12,     8,    19,    12 ]

racc_action_check = [
     1,     0,     1,    13,    10,    13,     8,     0,     1,     6,
    11,    12,     5,    15,    19 ]

racc_action_pointer = [
    -1,     0,   nil,   nil,   nil,     9,     9,   nil,     1,   nil,
    -4,     6,     3,    -1,   nil,     6,   nil,   nil,   nil,     6,
   nil ]

racc_action_default = [
   -11,   -11,    -1,    -3,    -4,   -11,   -11,    -2,   -11,    21,
   -11,   -11,    -9,   -11,    -6,   -11,   -10,    -5,    -7,   -11,
    -8 ]

racc_goto_table = [
    11,    14,    16,    18,     2,     7,    13,     1,   nil,    20 ]

racc_goto_check = [
     4,     6,     4,     6,     2,     2,     5,     1,   nil,     4 ]

racc_goto_pointer = [
   nil,     7,     4,   nil,   -10,    -5,   -10 ]

racc_goto_default = [
   nil,   nil,   nil,     3,   nil,   nil,   nil ]

racc_reduce_table = [
  0, 0, :racc_error,
  1, 10, :_reduce_1,
  2, 10, :_reduce_2,
  1, 11, :_reduce_3,
  1, 11, :_reduce_4,
  6, 12, :_reduce_5,
  1, 14, :_reduce_none,
  2, 14, :_reduce_7,
  3, 15, :_reduce_8,
  1, 13, :_reduce_none,
  2, 13, :_reduce_none ]

racc_reduce_n = 11

racc_shift_n = 21

racc_token_table = {
  false => 0,
  :error => 1,
  :DEFINE => 2,
  :NAME => 3,
  :PARAM => 4,
  :LCURLY => 5,
  :RCURLY => 6,
  :VALUE => 7,
  :RETURN => 8 }

racc_nt_base = 9

racc_use_result_var = true

Racc_arg = [
  racc_action_table,
  racc_action_check,
  racc_action_default,
  racc_action_pointer,
  racc_goto_table,
  racc_goto_check,
  racc_goto_default,
  racc_goto_pointer,
  racc_nt_base,
  racc_reduce_table,
  racc_token_table,
  racc_shift_n,
  racc_reduce_n,
  racc_use_result_var ]

Racc_token_to_s_table = [
  "$end",
  "error",
  "DEFINE",
  "NAME",
  "PARAM",
  "LCURLY",
  "RCURLY",
  "VALUE",
  "RETURN",
  "$start",
  "decls",
  "decl",
  "object",
  "returns",
  "vars",
  "var" ]

Racc_debug_parser = false

##### State transition tables end #####

# reduce 0 omitted

module_eval(<<'.,.,', 'grammar.ry', 6)
  def _reduce_1(val, _values, result)
     return val[0] if val[0] 
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.ry', 8)
  def _reduce_2(val, _values, result)
            if val[1].nil?
            result = val[0]
        else
            if val[0].nil?
                result = val[1]
            else
                result = [ val[0], val[1] ].flatten
            end
        end
    
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.ry', 20)
  def _reduce_3(val, _values, result)
     result = [val[0]] 
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.ry', 21)
  def _reduce_4(val, _values, result)
     result = nil 
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.ry', 25)
  def _reduce_5(val, _values, result)
            result = Nagios::Base.create(val[1],val[4])
    
    result
  end
.,.,

# reduce 6 omitted

module_eval(<<'.,.,', 'grammar.ry', 31)
  def _reduce_7(val, _values, result)
            val[1].each {|p,v|
            val[0][p] = v
        }
        result = val[0]
    
    result
  end
.,.,

module_eval(<<'.,.,', 'grammar.ry', 38)
  def _reduce_8(val, _values, result)
     result = {val[0] => val[1]} 
    result
  end
.,.,

# reduce 9 omitted

# reduce 10 omitted

def _reduce_none(val, _values, result)
  val[0]
end

  end   # class Parser
  end   # module Nagios
