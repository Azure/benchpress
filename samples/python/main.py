# from benchpress import resource_group
# from benchpress import storage_account
# from unittest import assert

def storage_account_test():
    print("storage_account_test")
    resource_group = None
    try:
        print("try")
        # Assemble
        print("assemble")

        # Provision the resource group
        azure_subscription = "random_uuid"
        # resource_group = resource_group.create(azure_subscription)

        # Act
        print("act")

        # Provision the Storage Account
        storage_account_params = {
            "a": 1,
            "b": 2,
            "c": 3
        }
        # status = storage_account.create(resource_group, storage_account_params )
        
        # Assert
        # Verify the resource group and contained resources were created, with the correct parameters
        print("assert")
        # assert.assert_true(benchpress.resource_group_exists(resource_group))
        # assert.assert_true(status.SUCCESS)
        # assert.assert_equals(status.sa_property_a, storage_account_params.a)
        # assert.assert_equals(status.sa_property_b, storage_account_params.b)
        # assert.assert_equals(status.sa_property_c, storage_account_params.c)

        # dev only
        raise ValueError("dev only exception for positively asserting try-finally works") 
    except:
        # CRITIAL: We MUST include an "except" block or "finally" will not run
        print("except")
        pass
    finally:
        # Destroy the provisioned resourvce group
        print("finally")
        # benchpress.destroy(resource_group)

def main():
    print("main")
    storage_account_test()


if __name__ == "__main__":
    main()
