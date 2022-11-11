class Response():
    def __init__(self) -> None:
        self.success = False
        self.a = None
        self.b = None
        self.c = None


def create(resource_group: str, params: dict) -> Response:
    if resource_group and params:
        response = Response()
        response.success = True
        return response
    return Response()


if __name__ == "__main__":
    pass