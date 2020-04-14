//namespace Quantum.QSharpConsole {
//
//    open Microsoft.Quantum.Canon;
//    open Microsoft.Quantum.Intrinsic;
//
//   
//    operation HelloQ () : Unit {
//        Message("Hello quantum world!");
//    }
//}

namespace Quantum.Bell {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;

    operation Set(desired : Result, q1 : Qubit) : Unit {
        if (desired != M(q1)) {
            X(q1);
        }
    }

    operation TestBellState(count : Int, initial : Result) : (Int, Int) {
        mutable numOnes = 0;
        using (qubit = Qubit()) {

            for (test in 1..count) {
                Set(initial, qubit);
                let res = M(qubit);

                // Count the number of ones we saw:
                if (res == One) {
                    set numOnes += 1;
                }
            }
            Set(Zero, qubit);
        }

        // Return number of times we saw a |0> and number of times we saw a |1>
        return (count-numOnes, numOnes);
    }

    ///Flip X
    operation TestBellStateFlip(count : Int, initial : Result) : (Int, Int) {
        mutable numOnes = 0;
        using (qubit = Qubit()) {

            for (test in 1..count) {
                Set(initial, qubit);
                //flip
                X(qubit);
                let res = M(qubit);

                // Count the number of ones we saw:
                if (res == One) {
                    set numOnes += 1;
                }
            }
            Set(Zero, qubit);
        }

        // Return number of times we saw a |0> and number of times we saw a |1>
        return (count-numOnes, numOnes);
    }

    ///Hadamard H
    operation TestBellStateHadamard(count : Int, initial : Result) : (Int, Int) {
        mutable numOnes = 0;
        using (qubit = Qubit()) {

            for (test in 1..count) {
                Set(initial, qubit);
                //Recentrer la valeur du Qbit entre 0 et 1 en utilisant l'operateur Hadamard
                H(qubit);
                let res = M(qubit);

                // Count the number of ones we saw:
                if (res == One) {
                    set numOnes += 1;
                }
            }
            Set(Zero, qubit);
        }

        // Return number of times we saw a |0> and number of times we saw a |1>
        return (count-numOnes, numOnes);
    }

    ///
    operation TestBellStateIntrication(count : Int, initial : Result) : (Int, Int, Int) {
        
        mutable numOnes = 0;
        mutable agree = 0;

        using ((q0, q1) = (Qubit(), Qubit())) {

            for (test in 1..count) {
                Set(initial, q0);
                Set(Zero, q1);

                //Recentrer la valeur du Qbit entre 0 et 1 en utilisant l'operateur Hadamard
                H(q0);
                //Enchevetrer les deux Qbits
                CNOT(q0, q1);

                let res = M(q0);

                if(res == M(q1))
                {
                    set agree += 1;
				}

                // Count the number of ones we saw:
                if (res == One) {
                    set numOnes += 1;
                }
            }
            Set(Zero, q0);
            Set(Zero, q1);
        }

        // Return number of times we saw a |0> and number of times we saw a |1>
        return (count-numOnes, numOnes, agree);
    }
}

