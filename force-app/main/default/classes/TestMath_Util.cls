@isTest
private class TestMath_Util {
    @isTest static void TestBaseFibonacci_Serie(){
        integer result = Math_Util.Fibonacci_Serie(0);
        integer result1 = Math_Util.Fibonacci_Serie(1);
        System.assert(result==0);
         System.assert(result1==1);
    }
     @isTest static void TestFibonacci_Serie(){
        integer result = Math_Util.Fibonacci_Serie(3);
        System.debug(result);
        System.assert(result==2);
    }
     @isTest static void RunOnce(){
         integer cont=0;
        while(Math_Util.runOnce())
        {
            cont++;
        }
         System.assert(cont==1);
    }
    
}