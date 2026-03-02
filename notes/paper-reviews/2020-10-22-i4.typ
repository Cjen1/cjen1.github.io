#import "../tkf.typ": *
#kt-note(id: "notes/paper-reviews/2020-10-22-i4.typ", title: "I4: Incremental Inference of Inductive Invariants for Verification of Distributed Protocols", tags: ("papers", "distributed-systems", "verification"), author: "", date: "2020-10-22", api => [

= Overview

This paper#footnote[Ma, H. _et al._ I4: Incremental Inference of Inductive Invariants for Verification of Distributed Protocols. in _Proceedings of the 27th ACM Symposium on Operating Systems Principles_ 370--384 (Association for Computing Machinery, 2019). doi:#link("https://doi.org/10.1145/3341301.3359651")[10.1145/3341301.3359651].] investigates ways to reduce the cost of formally verifying protocols. Specifically it highlights that when verifying systems, there tends to be two phases, the first is verifying the protocol by finding inductive invariants. The second phase is proving that the code implements the protocol.

They claim that the second phase is relatively easy and that it is the first phase which is the difficult part. They cite the Ironfleet paper#footnote[Hawblitzel, C. _et al._ IronFleet: Proving Practical Distributed Systems Correct. in _Proceedings of the ACM Symposium on Operating Systems Principles (SOSP)_ (ACM - Association for Computing Machinery, 2015).] for this:

#quote[when they attempted to find the inductive invariant of \[Paxos\] the required effort was on the order of months]

Hence this paper focuses on automating the discovery of inductive invariants.

There have been several systems which have attempted similar things, the most notable of these being Ivy.#footnote[Padon, O., McMillan, K. L., Panda, A., Sagiv, M. & Shoham, S. Ivy: Safety Verification by Interactive Generalization. in _Proceedings of the 37th ACM SIGPLAN Conference on Programming Language Design and Implementation_ 614--630 (Association for Computing Machinery, 2016). doi:#link("https://doi.org/10.1145/2908080.2908118")[10.1145/2908080.2908118].] Ivy works by taking a starting invariant and iteratively producing minimised counterexamples until the infinite invariant is found.

The key idea for I4 is rather than finding the inductive invariant for the infinite version of the protocol directly (for example with a lock server having `c` clients) you can relatively easily generate an invariant for a finite domain (for example two clients) and then generalise to the infinite one.

The key issue then is finding a sufficiently large finite domain which encompasses all behaviors which are relevant to the final invariant while not exceeding the computation time and more importantly memory of the model checker.

To use a concrete example: if we want to prove that a locking protocol will not permit more than one client to hold a lock at a given time, we could start with a single server and client. The issue is that the safety property is trivially always true in this case and hence we can't derive the generalised invariant. Thus we weaken the assumption that there is a single client to having two clients which should expose all interesting behaviors.

Their specific workflow for I4 is as follows:

+ Write out desired safety property and system model.
+ Feed the model and property into a model checker for finite (small) domains.
+ Generate small invariant using Ivy.
+ Remove finite boundaries on domains applied in step 2.
+ Iteratively use Ivy to generate a generalised version of the invariant, expanding the domains as required.

= Conclusion

Overall this paper is very exciting and provides a relatively simple way to verify complex protocols in an automated fashion without requiring substantial intimate knowledge of the protocols themselves. Thus this opens the door to engineers optimising protocols for their specific purpose while still being able to verify the resultant system.

That being said the system is currently limited by the size of the domains it can check, however the authors note that by using a different style of model checker they may be able to partially resolve this.

One final thought on this limit is that fundamentally we will always be limited in man power and effort of the complexity of systems that we can verify, all that matters is whether useful work can be done using it.
])
