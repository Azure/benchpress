interface ILifecycleManager {
    void Init();
    void PreEngineStart(int retryCount=3, int httpTimeout=60000, bool keepAlive=true);
    void StartEngine();
    void StopEngine();
}
