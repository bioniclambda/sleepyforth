dict = {}
dictpos = 1

function create_word(name, value)
	local i = 1

	while (dict[i] ~= nil) do
		if (dict[i].name == name) then
			dict[i].value = value
			return
		end
	end
	
	table.insert(dict, dictpos, {name = name, value = value})
	dictpos = dictpos + 1
end

STACK_LIMIT = 1024

stack = {}
stackpos = 1

function push(val)

	if (type(val) ~= 'number') then
		return 0;
	end

	if (stackpos >= STACK_LIMIT) then
		return 0
	end
	
	stack[stackpos] = val;
	stackpos = stackpos + 1
end

function pop()

	if (stackpos == 1) then -- Stack is empty. Arrays start at 1 in Lua
		return 0;
	end
	
	local val = stack[stackpos - 1]
	stackpos = stackpos - 1
	return val
end

function swap()

	if (stackpos < 3) then -- Stack is too short to swap. Arrays start at 1 in Lua
		return
	end

	local val1 = pop() -- Using val1 and val2 instead of val0 and val1
	local val2 = pop() -- because arrays start at 1 in Lua

	push(val1)
	push(val2)
end

function dup()
	push(stack[stackpos - 1])
end



function split(s, delimiter)
	local result = {}

	for match in (s..delimiter):gmatch('(.-)'..delimiter) do
		table.insert(result, match)
	end

	return result
end

function interpret(code)
	local tokens = split(code, ' ')
	local token
	local word

	local itr = 1
	
	for i in pairs(tokens) do
		
		is_word = false
		token = tokens[itr]

		if (token == '+') then
			push(pop() + pop())

		elseif (token == '-') then
			swap()
			push(pop() - pop())

		elseif (token == '*') then
			push(pop() * pop())

		elseif (token == '/') then
			swap()
			push(pop() / pop())

		elseif (token == '.') then
			io.write(pop())

		elseif (token == 'drop') then
			pop()

		elseif (token == 'swap') then
			swap()

		elseif (token == 'dup') then
			dup()

		elseif (token == '<') then
			swap()
			if (pop() < pop()) then
				push(1)
			else
				push(0)
			end

		elseif (token == '>') then
			swap()
			if (pop() > pop()) then
				push(1)
			else
				push(0)
			end

		elseif (token == 'if') then
			if_count = 1
			if (pop() == 0) then
				while (tokens[itr] ~= 'end' and if_count > 0) do
					if (tokens[itr] == 'if') then
						if_count = if_count + 1
					
					elseif (tokens[itr] == 'end') then
						if_count = id_count - 1
					end
					
					itr = itr + 1 -- If pop is 0, then skip all tokens until end
				end
			end

		elseif (token == ':') then
			local tempcode = '' -- temporary code
			local temp_pos = 1
			local word_name
			
			while (tokens[itr] ~= ';') do
				if (tokens[itr] ~= ':') then
					if (temp_pos == 1) then
						name = tokens[itr]
					else
						tempcode = tempcode .. tokens[itr] .. ' '
					end

					temp_pos = temp_pos + 1
				end

				itr = itr + 1
			end

			create_word(name, tempcode)	

		else
			local is_word
			
			for j in pairs(dict) do
				word = dict[j]

				if (token == word.name) then
					interpret(word.value)
					is_word = true
				end
			end

			if (not is_word) then
				push(tonumber(token))
			end
		end

		itr = itr + 1
	end
end

s = ''

while (s ~= 'exit') do
	io.write('\n>> ')
	s = io.read('*l')
	interpret(s)
end
