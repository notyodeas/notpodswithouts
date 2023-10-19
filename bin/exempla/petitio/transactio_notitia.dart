class TransactionNotatia {
  final bool includi;
  final List<String> priorTxIds;
  final int? indicatione;
  final List<int>? obstructionumNumerus;
  final BigInt? confirmationes;
  TransactionNotatia(this.includi, this.priorTxIds, this.indicatione,
      this.obstructionumNumerus, this.confirmationes);

  Map<String, dynamic> toJson() => {
        'includi': includi,
        'confirmationes': confirmationes.toString(),
        'priorTxIds': priorTxIds,
        'indicatione': indicatione,
        'obstructionumNumerus': obstructionumNumerus,
      };
}
