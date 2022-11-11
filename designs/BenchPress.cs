using System.Reflection;

public enum State
{
    PreInitialization,
    Initialization,
    EngineStarting,
    EngineStartSuccess,
    EngineStartFailure,
    TestExecute,
    Shutdown,
    EngineShutdownSuccess,
    Done
}

// The choice of name of the class is not significant and is subject
// to change by the desginer.
// 
// At time of writing, this class is not intended to be in a 
// compilable or executable state.
// 
// The objective of this class design artifact is serve as a guide 
// for a developer to programatically manage the lifecycle of the 
// BenchPress Engine and the State Machine it will implement.
public class BenchPress : ILifecycleManager
{
    private static readonly object lockObj = new object();
    private static BenchPress? instance = null;

    private const int MaxRestart = 2;

    public int EnginePID { get; private set; } = -1;

    public State CurrentState { get; private set; } = State.PreInitialization;

    public static BenchPress Instance
    {
        get
        {
            if (instance == null)
            {
                lock (lockObj)
                {
                    instance = new BenchPress();
                }
            }
            return instance;
        }
    }

    private BenchPress()
    {
        TransitionToNextState(State.Initialization);
    }

    private void Process()
    {
        switch (CurrentState)
        {
            case State.Initialization: Init(); break;
            case State.EngineStarting: 
                PreEngineStart();
                StartEngine();
                break;
            case State.EngineStartSuccess: OnEngineStartSuccess(); break;
            case State.EngineStartFailure: OnEngineStartFailure(); break;
            case State.TestExecute: OnTestExecute(); break;
            case State.Shutdown: StopEngine(); break;
            case State.EngineShutdownSuccess: Teardown(); break;
            case State.Done: Done(); break;
        }
    }

    private void TransitionToNextState(State nextState)
    {
        if (nextState != CurrentState)
        {
            CurrentState = nextState;
            Process();
        }
    }

    public void Init()
    {
        TransitionToNextState(State.EngineStarting);
    }

    public void PreEngineStart(int retryCount=3, int httpTimeout=60000, bool keepAlive=true) { }

    public async void StartEngine()
    {
        var isStarted = false;
        try
        {
            Monitor.Enter(lockObj);
            try
            {
                var restartCount = 0;

                while (!isStarted && restartCount < MAX_RESTART)
                {
                    restartCount++;

                    int enginePID = await MockStartProcess();
                    if (enginePID > 0)
                    {
                        isStarted = true;
                    }
                }
            }
            finally
            {
                Monitor.Exit(lockObj);
            }
        }
        catch (SynchronizationLockException SyncEx)
        {
            Console.WriteLine("A SynchronizationLockException occurred. Message: ");
            Console.WriteLine(SyncEx.Message);
        }

        if (isStarted)
        {
            TransitionToNextState(State.EngineStartSuccess);
        }
        else
        {
            TransitionToNextState(State.EngineStartFailure);
        }
    }

    private void OnEngineStartSuccess()
    {
        TransitionToNextState(State.TestExecute);
    }

    private void OnEngineStartFailure()
    {
        TransitionToNextState(State.Shutdown);
    }

    private void PreTestExecute() { }

    private void OnTestExecute()
    {
        var testMethods = GetMethodsWithAttribute(typeof(BenchpressTestAttribute));

        // Invoke the test
        testMethods.ToList().ForEach(method =>
        {
            InvokeTest(method);
        });

        TransitionToNextState(State.Shutdown);
    }

    public async void StopEngine()
    {
        try
        {
            Monitor.Enter(lockObj);
            try
            {
                int exitCode = await MockStopProcess(EnginePID);
            }
            finally
            {
                Monitor.Exit(lockObj);
            }
        }
        catch (SynchronizationLockException SyncEx)
        {
            Console.WriteLine("A SynchronizationLockException occurred. Message: ");
            Console.WriteLine(SyncEx.Message);
        }
        TransitionToNextState(State.EngineShutdownSuccess);
    }

    private void Teardown()
    {
        InvokeMethodsMarkedWithAttribute(typeof(OnShutdownAttribute));
        TransitionToNextState(State.Done);
    }

    private void Done() { }

    private void InvokeTest(MethodInfo method)
    {
        // pre
        //InvokeMethodsMarkedWithAttribute(BenchPress.Attributes.PreTestExecute);

        // execute
        //InvokeMethodsMarkedWithAttribute(BenchPress.Attributes.Test);

        // post
        InvokeMethodsMarkedWithAttribute(typeof(OnTestExecuteAttribute));
    }

    private MethodInfo[] GetMethodsWithAttribute(params Type[] attributes)
    {
        return new MethodInfo[] { };
    }

    private void InvokeMethodsMarkedWithAttribute(params Type[] attributes)
    {
        /* logic */
        /*foreach (Attribute attr in attributes)
        {
            foreach (MethodInfo method in attr)
            {
                if (HasAttribute(method, attr))
                {
                    method.Invoke();
                }
            }
        }*/
    }

    private async Task<int> MockStartProcess()
    {
        int PID = -1;
        await Task.Run(() =>
        {
            PID = 1;
        });
        return PID;
    }

    private async Task<int> MockStopProcess(int PID)
    {
        int EXIT_CODE = -1;
        await Task.Run(() =>
        {
            EXIT_CODE = 0;
        });
        return EXIT_CODE;
    }
}
