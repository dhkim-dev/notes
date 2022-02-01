require "shopify/adt"

res = Shopify::Adt::Result.ok("good")
res_ = res.ok_value_or_else do |errors|
  p errors # no role
  "fallback return val" # no role
end
p res_