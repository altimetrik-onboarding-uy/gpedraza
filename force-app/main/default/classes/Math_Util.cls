public class Math_Util {
    public static integer Fibonacci_Serie(decimal val){
        if(val ==0 )
            return 0;
        else if (val == 1)
            return 1;
        else{
            return Fibonacci_Serie(val - 1) + Fibonacci_Serie(val - 2);
        }
    }
    private static boolean run = true;
    public static boolean runOnce()
    {
        if(run)
        {
            run=false;
            return true;
        }
        else
            return run;
    }

}