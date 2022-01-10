# typed: true
extend T::Sig

"""
There are five ways to assert the types of expressions in Sorbet:

T.let(expr, Type)
T.cast(expr, Type)
T.must(expr)
T.assert_type!(expr, Type)
T.bind(self, Type)

We've seen T.let before.
"""
