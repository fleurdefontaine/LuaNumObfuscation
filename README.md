# Lua Number Obfuacation

Lua Number Obfuscation adalah script untuk mengubah angka menjadi bentuk yang lebih sulit dibaca atau dimengerti, tetapi masih dapat dievaluasi dengan benar oleh Lua. Misalnya, mengganti angka dengan ekspresi matematis atau bitwise yang menghasilkan nilai yang sama.

#### Example Usage
```local res = createBitwise(18) -- Minimal harus di atas angka 5
print(res)

--[[ Contoh output:
((((14& ~(#"\3\1\2\2\1\6")))+((14-(#"\1\6\0\9")))))
]]
