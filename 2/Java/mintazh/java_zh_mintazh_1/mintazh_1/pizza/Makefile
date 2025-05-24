CP = .:junit-4.12.jar:hamcrest-core-1.3.jar
files = \
	preri/pizza/Food.java \
	preri/pizza/utils/Ingredient.java \
	preri/pizza/utils/CartException.java \
	preri/pizza/utils/PizzaSize.java \
	preri/pizza/Cart.java \
	preri/pizza/Pizza.java \
	preri/test/PreriTester.java

all: $(files:%.java=%.class)

%.class: %.java
	javac -cp $(CP) $^

test:
	java -cp $(CP) org.junit.runner.JUnitCore preri.test.PreriTester

clean:
	rm -f $(files:%.java=%.class)

.PHONY: all test
