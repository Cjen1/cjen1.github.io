#import "../tkf.typ": *
#tkf-note(id: "notes/2026-03-02-usa-taxes.typ", title: "USA taxes", tags: (), author: "", date: "2026-03-02", api => [
#let transclude = api.transclude
#let notelink = api.notelink

As always a pain.

Important docs: stock 1099, pay slips.

I also have #link("https://github.com/cjen1/monzo-us-tax-scripts")[scripts to get info from monzo csvs].

== Stock Awards

Kinda crazily calculated but it works out.
The award itself is taxable income.
Then as you don't actually receive it in your paycheck, that is deducted.
But as this now means on that paycheck you owe more tax, they deduct that extra amount from the stocks awarded, and give you this as a negative deduction.

So the end result is that your regular paycheck shows the award, but your takehome pay does not substantially change.

However this at Microsoft doesn't include national insurance or student finance repayments, so those are still deducted from the paycheck.
])
