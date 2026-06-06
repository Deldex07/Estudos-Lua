function fat (n)
    if n<0 then return 0 end
    if n == 0 then
    return 1
    else
    return n * fat(n-1)
    end
end
print("entre com um número:")
a = io.read("*number")
print(fat(a))