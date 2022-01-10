require "sorbet-runtime"
require "set"

# typed: true
extend T::Sig

"""
Need to pass sig a method signature block

sig do
    params(
      x: SomeType,
      y: SomeOtherType,
    )
    .returns(MyReturnType)
end

Params must be given arguments. Therefore, for no-arg methods, remove the params method entirely.

sig do
    returns(MyReturnType)
end

Note: Ruby methods always return a value. Therefore, you will always declare that you return something - be it a NilClass or some other <T>.
"""

"""
no-args w/ return value
"""
sig {params().returns(NilClass)}
def greet
    p "Hello, world"
end

# more common is to use void...

"""
no args, non-void return
"""
sig {returns(Integer)}
def im_feeling
    return 22
end

"""
args, void return
"""
sig {params(x: Numeric, y: Integer).returns(String)}
def print_sum(x, y)
    return 3
end

print_sum(1, 2)