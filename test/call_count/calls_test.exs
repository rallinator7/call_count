defmodule CallCount.CallsTest do
  use CallCount.DataCase

  alias CallCount.Calls

  describe "calls" do
    alias CallCount.Calls.Call

    @valid_attrs %{clientId: "some clientId", day: 42, hour: 42, month: 42, year: 42}
    @update_attrs %{clientId: "some updated clientId", day: 43, hour: 43, month: 43, year: 43}
    @invalid_attrs %{clientId: nil, day: nil, hour: nil, month: nil, year: nil}

    def call_fixture(attrs \\ %{}) do
      {:ok, call} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Calls.create_call()

      call
    end

    test "list_calls/0 returns all calls" do
      call = call_fixture()
      assert Calls.list_calls() == [call]
    end

    test "get_call!/1 returns the call with given id" do
      call = call_fixture()
      assert Calls.get_call!(call.id) == call
    end

    test "create_call/1 with valid data creates a call" do
      assert {:ok, %Call{} = call} = Calls.create_call(@valid_attrs)
      assert call.clientId == "some clientId"
      assert call.day == 42
      assert call.hour == 42
      assert call.month == 42
      assert call.year == 42
    end

    test "create_call/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Calls.create_call(@invalid_attrs)
    end

    test "update_call/2 with valid data updates the call" do
      call = call_fixture()
      assert {:ok, %Call{} = call} = Calls.update_call(call, @update_attrs)
      assert call.clientId == "some updated clientId"
      assert call.day == 43
      assert call.hour == 43
      assert call.month == 43
      assert call.year == 43
    end

    test "update_call/2 with invalid data returns error changeset" do
      call = call_fixture()
      assert {:error, %Ecto.Changeset{}} = Calls.update_call(call, @invalid_attrs)
      assert call == Calls.get_call!(call.id)
    end

    test "delete_call/1 deletes the call" do
      call = call_fixture()
      assert {:ok, %Call{}} = Calls.delete_call(call)
      assert_raise Ecto.NoResultsError, fn -> Calls.get_call!(call.id) end
    end

    test "change_call/1 returns a call changeset" do
      call = call_fixture()
      assert %Ecto.Changeset{} = Calls.change_call(call)
    end
  end
end
