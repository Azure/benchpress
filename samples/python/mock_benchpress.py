def resource_group_exists(resource_group: str) -> bool:
    print("ResourceGroup: " + resource_group)
    return True

def create_resource_group(azure_subscription: str) -> str:
    print("Subscription: " + azure_subscription)
    return "dummy_resource_group_id"

def destroy(resource_group: str):
    print("Deleting ResourceGroup: " + resource_group)

if __name__ == "__main__":
    pass
