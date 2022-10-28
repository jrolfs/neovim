return function(mode)
  local m = string.lower(mode)

  if m == 'normal' then
    return ''
  elseif m == 'insert' then
    return ''
  elseif m == 'visual' then
    return ''
  elseif m == 'v-line' then
    return ''
  elseif m == 'v-block' then
    return ''
  end

  print(m)
end

