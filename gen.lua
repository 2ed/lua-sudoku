--[[
http://oldschooldotnet.blogspot.ru/2008/11/c-latin-squares-or-shuffling-2d-array.html

3 1 8 9 2 4 5 7 6

8:
1 3
2 1

j1 i1
j2 i2

math.floor((j1-1)/3+1) ~= math.floor((j2-1)/3+1) and math.floor((i1-1)/3+1) ~= math.floor((i2-1)/3+1) 


math.randomseed( os.time() )
local t = ''
for i = -4,9 do
    local new
    new = math.random(9)
    if i > 0 then repeat
            new = math.random(9)
            until not t:find(new)
        t = t..new
        print(t)
    end
end

check = function (l,i)
if not i then i = 2
    for i = i, #l do 
        if 
    end
end

--]]

a = {{},{},{}}
a[1] = {1,2,3,4,5,6,7,8,9}
a[2] = {4,5,6,0,8,9,1,2,3}
a[3] = {7,8,9,1,2,3,4,5,6}
a[4] = {2,3,0,5,0,7,8,9,1}
a[5] = {5,6,7,8,9,1,2,3,4}
a[6] = {8,9,1,2,3,4,5,6,7}
a[7] = {3,4,5,6,7,8,0,1,2}
a[8] = {6,7,8,9,1,2,3,4,5}
a[9] = {9,1,2,3,4,5,6,7,8}

z = {}
iter = function (t, mode, j, i )
	if mode == 'full' then
		return function (tab, c)
			c.i = c.i + 1
			if c.i > #a  then 
				c.j = c.j + 1 c.i = 1
			end
			if c.j < #tab + 1 then
				return c, tab[c.j][c.i]
			end
		end, t, {j = 1, i = 0}
	end
end

function pr(a)
	for c, p in iter(a, 'full') do
		s = s and ((c.i % 3 - 1 == 0 and c.i ~= 1) and s..'|'..p or s..' '..p) or ' '..p
		if c.i == #a then 
			print (s) 
			s = '' 
			print ((c.j%3 == 0 and c.j~=#a) and ' -----------------' or '') 
		end
	end
end 

function zero (a) 
	for c,p in iter(a,'full') do 
		if p == 0 then
			table.insert(z,c)
		--print (z[#z].j,z[#z].i)
		end
	end
end