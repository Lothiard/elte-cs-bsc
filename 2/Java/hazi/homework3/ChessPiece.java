package homework3;

public enum ChessPiece {
  PAWN(1), KNIGHT(3), BISHOP(3), ROOK(5), QUEEN(9);

  private int baseValue;

  ChessPiece(int baseValue) {
    this.baseValue = baseValue;
  }

  public int getBaseValue() {
    return baseValue;
  }

  public boolean isGreaterValue(ChessPiece other) {
    return this.baseValue > other.baseValue;
  }
}
