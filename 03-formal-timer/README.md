# Formal verification: timer

A 16-bit countdown timer (`load`, `cycles`, `busy`) verified with SymbiYosys.

**Cover properties** – the solver must find traces where the timer is loaded, starts (`busy` rises) and finishes (`busy` falls).

**Assertions**
1. If the counter is non-zero, `busy` is high.
2. One cycle after `load`, the counter holds the loaded `cycles` value.
3. While busy and not reloaded, the counter decrements by exactly 1 each cycle.

**Lessons:** without extra conditions the solver satisfied the "finished" cover by simply asserting reset. Using `f_past_valid` and `$past(reset)` excludes those trivial traces, and stops `$past()` from being read on the first cycle when it has no history.

```sh
sby -f timer.sby      # result: PASS
```
