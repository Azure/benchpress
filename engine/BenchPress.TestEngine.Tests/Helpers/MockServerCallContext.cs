namespace BenchPress.TestEngine.Tests;

public class MockServerCallContext : ServerCallContext
{
    protected override string MethodCore => throw new NotImplementedException();

    protected override string HostCore => throw new NotImplementedException();

    protected override string PeerCore => throw new NotImplementedException();

    protected override DateTime DeadlineCore => throw new NotImplementedException();

    protected override Metadata RequestHeadersCore => throw new NotImplementedException();

    protected override CancellationToken CancellationTokenCore => throw new NotImplementedException();

    protected override Metadata ResponseTrailersCore => throw new NotImplementedException();

    protected override Status StatusCore { get => throw new NotImplementedException(); set => throw new NotImplementedException(); }
    protected override WriteOptions WriteOptionsCore { get => throw new NotImplementedException(); set => throw new NotImplementedException(); }

    protected override AuthContext AuthContextCore => throw new NotImplementedException();

    protected override ContextPropagationToken CreatePropagationTokenCore(ContextPropagationOptions options)
    {
        throw new NotImplementedException();
    }

    protected override Task WriteResponseHeadersAsyncCore(Metadata responseHeaders)
    {
        throw new NotImplementedException();
    }
}
