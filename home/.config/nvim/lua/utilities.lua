local M = {}

M.merge = function(table1, table2)
  for k, v in pairs(table2) do
    if type(v) == 'table' then
      table1[k] = M.merge(table1[k], table2[k])
    else
      table1[k] = v
    end
  end

  return table1
end

return M
