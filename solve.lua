#!/usr/bin/lua

a ={
	{ 6,7,0,3,4,1,0,5,0 };
	{ 5,0,0,0,8,0,0,7,0 };
	{ 0,8,0,0,5,0,3,1,2 };
	{ 0,5,0,0,6,0,0,9,7 };
	{ 7,0,0,4,2,8,0,0,1 };
	{ 3,1,4,5,0,0,2,0,0 };
	{ 1,4,7,0,0,5,0,0,9 };
	{ 8,0,0,0,0,4,7,6,0 };
	{ 0,0,3,0,0,2,1,0,5 };
}

b = {
	{ 0,0,9,7,0,0,2,0,5 };
	{ 1,3,7,0,0,8,4,0,0 };
	{ 0,6,0,9,3,0,1,0,0 };
	{ 0,7,0,0,5,3,0,4,0 };
	{ 8,4,0,0,0,9,0,7,2 };
	{ 0,9,3,0,4,0,6,0,1 };
	{ 9,2,8,0,0,0,0,6,4 };
	{ 7,0,6,4,0,5,0,0,3 };
	{ 0,0,0,0,8,2,7,1,0 };
}

c = {
	{ 3,0,7,4,0,0,2,0,0 };
	{ 0,0,4,0,0,0,0,0,0 };
	{ 0,0,0,0,0,0,5,1,0 };
	{ 0,0,0,0,1,3,0,9,0 };
	{ 0,0,0,5,9,0,0,0,8 };
	{ 0,0,0,2,0,0,0,0,0 };
	{ 7,6,0,0,2,0,0,0,0 };
	{ 0,0,0,8,0,0,0,2,0 };
	{ 9,1,0,0,3,0,0,0,0 };
}

h = {
	{ 0,0,0,3,2,0,0,0,7 };
	{ 0,0,0,0,0,0,1,0,0 };
	{ 0,0,3,0,0,0,0,2,0 };
	{ 0,0,0,0,0,0,2,0,0 };
	{ 3,2,0,0,0,0,0,7,0 };
	{ 0,0,1,0,0,9,4,0,0 };
	{ 0,0,0,7,0,0,0,0,0 };
	{ 0,0,0,0,0,0,0,9,2 };
	{ 0,0,0,8,0,3,0,0,0 };	
}



zeros = function (t)
	local z = {}
	for i = 1,9 do
		for j = 1,9 do 
			if t[j][i] == 0 then
				table.insert(z,10*j+i)
			end
		end
	end
	return z
end

howmany = function (s,simb)
	local n = 0
	if s then 
	while s:find(simb) do
		s = s:sub(s:find(simb)+1,s:len())
		n = n+1
	end	
	end
	if s then return n
	else return 0
	end
end

check = function (t,n,deep)
	local sr,sc,sq, s ='','','','123456789'
	for i = 1,9 do 
		local res = s:find(t[math.floor(n/10)][i])
		if res then 
			s = s:sub(1,res-1) .. s:sub(res+1,s:len())
		end
		if t[math.floor(n/10)][i] == 0 and not deep then 
			sr = check(t,n - n%10 + i,'no') .. sr
		end
	end
	for i = 1,9 do 
		local res = ''
		res = s:find(t[i][n%10])
		if res then 
			s = s:sub(1,res-1) .. s:sub(res+1,s:len())
		end
		if t[i][n%10] == 0 and not deep then 
			sc = check(t,i*10+n%10,'no') .. sc
		end
	end
	local nj, ni = math.floor((math.floor(n/10) -1)/3)*3, math.floor((n%10-1)/3)*3
	for i = 1,9 do 
		local res = ''
		local r,c = math.floor((i-1)/3)+1,math.floor((i-1)%3)+1
		res = s:find(t[nj+r][ni+c])
		if res then 
			s = s:sub(1,res-1) .. s:sub(res+1,s:len())
		end
		if t[nj+r][ni+c] == 0 and not deep then 
			sq = check(t,(nj+r)*10+ni+c,'no') .. sq
		end
	end
	for i = 1,9 do 
		if (howmany(sr,i) == 1 or howmany(sc,i) == 1 or howmany(sq,i) == 1) and s:find(i) then 
			do return tostring(i) end
			break
		elseif i == 9 then return s 
		end
	end
end



function pr(a)
	for j = 1,9 do 
		for i = 1,9 do
			io.write (' ' ..a[j][i])
			if i % 3 == 0 and i%9 ~= 0 then 
				io.write (' |')
			end
		end
		if j ~= 9 and j%3 == 0 then
			print ()
			print (' ---------------------')
		else print ()
		end
	end
	print()
end 

solveonce = function (a)
	local result = nil
	for m, i in pairs(z) do 
		n = check(a,i)
		if n:len() == 1 then 
			a[math.floor(i/10)][i%10] = n
			table.remove(z,m)
			result = 'yes'
		elseif n:len() == 0 then
		result = 'fail at row: '.. math.floor(i/10) ..' column: '.. i%10 ..' (at least)'
		end
	end
	return result
end

solve = function (t)
	local a,result = t
	while #z ~= 0 do 
		res = solveonce (a)
		if res and res ~= 'yes' then
			result = res
			break
		elseif not res then
			result = "I'm stuck ._."
			break
		end
	end
	if #z == 0 then result = 'Done ^ v^' end
	return result
end

printe = function (a)
	z = zeros(a)
	pr(a)
	print (solve (a))
	print()
	pr(a)
end

printe (c)

