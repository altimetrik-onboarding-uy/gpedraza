@isTest
private class TestMath_Util {
    @isTest static void TestBaseFibonacci_Serie(){
        integer caseBaseCero = Math_Util.Fibonacci_Serie(0);
        integer caseBaseOne = Math_Util.Fibonacci_Serie(1);
        System.assert(caseBaseCero == 0);
        System.assert(caseBaseOne == 1);
    }
     @isTest static void TestFibonacci_Serie(){
        integer caseNumberTwo = Math_Util.Fibonacci_Serie(3);
        System.debug(caseNumberTwo);
        System.assert(caseNumberTwo == 2);
    }
     @isTest static void RunOnce(){
        integer cont = 0;
        while(Math_Util.runOnce())
        {
            cont ++;
        }
        System.assert(cont == 1);
    }
    
}