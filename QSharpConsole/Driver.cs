using System;

using Microsoft.Quantum.Simulation.Core;
using Microsoft.Quantum.Simulation.Simulators;

namespace Quantum.Bell
{
    class Driver
    {
        static void Main(string[] args)
        {
            #region Concepts de base
            using (var qsim = new QuantumSimulator())
            {
                // Try initial values
                Result[] initials = new Result[] { Result.Zero, Result.One };
                foreach (Result initial in initials)
                {
                    var (numZerosNeutre, numOnesNeutre) = TestBellState.Run(qsim, 1000, initial).Result;

                    var (numZerosFlip, numOnesFlip) = TestBellStateFlip.Run(qsim, 1000, initial).Result;

                    var (numZerosHadamard, numOnesFlipHadamard) = TestBellStateHadamard.Run(qsim, 1000, initial).Result;

                    System.Console.WriteLine($"============ {initial} ============");

                    System.Console.WriteLine($"Neutre  : 0s={numZerosNeutre} 1s={numOnesNeutre}");
                    System.Console.WriteLine($"Flip    : 0s={numZerosFlip} 1s={numOnesFlip}");
                    System.Console.WriteLine($"Hadamard: 0s={numZerosHadamard} 1s={numOnesFlipHadamard}");
                }
            }

            System.Console.WriteLine("Press any key to continue...");
            Console.ReadKey();
            #endregion

            
        }
    }
}