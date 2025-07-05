from typing import Callable, Any


def excited_decorator(func: Callable[[], Any]) -> Callable[[], None]:
    def wrapper():
        func()
        print(f"{func()}!")

    return wrapper


def infinite_sequence():
    num = 0
    while True:
        yield num
        num += 1


for i in infinite_sequence():
    print(i, end=" ")
