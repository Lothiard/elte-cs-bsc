package homework3; 

import static check.CheckThat.*;
import static check.CheckThat.Condition.*;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.*;
import org.junit.jupiter.api.condition.*;
import org.junit.jupiter.api.extension.*;
import org.junit.jupiter.params.*;
import org.junit.jupiter.params.provider.*;
import check.*;

public class ChessPieceTest {
  private ChessPiece pawn = ChessPiece.PAWN;
  private ChessPiece knight = ChessPiece.KNIGHT;
  private ChessPiece bishop = ChessPiece.BISHOP;
  private ChessPiece rook = ChessPiece.ROOK;
  private ChessPiece queen = ChessPiece.QUEEN;

  @Test
  public void testBaseValuePawn() {
    assertEquals(1, pawn.getBaseValue(), "Pawn base value should be 1");
  }

  @Test
  public void testBaseValueKnight() {
    assertEquals(3, knight.getBaseValue(), "Knight base value should be 3");
  }

  @Test
  public void testBaseValueBishop() {
    assertEquals(3, bishop.getBaseValue(), "Bishop base value should be 3");
  }

  @Test
  public void testBaseValueRook() {
   assertEquals(5, rook.getBaseValue(), "Rook base value should be 5");
  }

  @Test
  public void testBaseValueQueen() {
   assertEquals(9, queen.getBaseValue(), "Queen base value should be 9");
  }

  @Test
  public void testIsGreaterValue() {
    assertTrue(queen.isGreaterValue(rook), "Queen should be greater than Rook");
    assertFalse(rook.isGreaterValue(queen), "Rook should not be greater than Queen");
    assertTrue(knight.isGreaterValue(pawn), "Knight should be greater than Pawn");
    assertFalse(pawn.isGreaterValue(knight), "Pawn should not be greater than Knight");
  }   
}
