import uuid
import unittest
import mock_benchpress as benchpress
import mock_storage_account_grpc_interface as storage_account

class ExampleTest(unittest.TestCase):
    def test_storage_account(self):
        resource_group = None
        try:
            # Assemble
            azure_subscription = uuid.uuid1()
            resource_group = benchpress.create_resource_group(azure_subscription)

            storage_account_params = { "a": 1, "b": 2, "c": 3 }

            # Act
            sa_status = storage_account.create(resource_group, storage_account_params)
            
            # Assert
            self.assertTrue(benchpress.resource_group_exists(resource_group))
            self.assertTrue(sa_status.success)
            self.assertEqual(sa_status.a, storage_account_params["a"])
            self.assertEqual(sa_status.b, storage_account_params["b"])
            self.assertEqual(sa_status.c, storage_account_params["c"])
        except:
            # CRITIAL: We MUST include an "except" block or "finally" will not run
            # Consider adding a linting rule to enforce try: except: finally
            print("no-op") # linter try-except-pass rule
        finally:
            # Fail gracefully no matter if the test ran to completion or not
            benchpress.destroy(resource_group)


if __name__ == "__main__":
    unittest.main()
