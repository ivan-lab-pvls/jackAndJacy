import 'package:flutter/material.dart';
import 'package:flutter_application_1/game/dataParams/constants.dart';

class PlusMinusButtons extends StatelessWidget {
  const PlusMinusButtons({
    super.key,
    required this.onPlusTap,
    required this.onMinusTap,
  });
  final VoidCallback onPlusTap;
  final VoidCallback onMinusTap;

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.25),
        width: ParamsAxis(context).width * 0.1,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color(0xfff3dcf5),
              Color(0xff9d24a5),
            ],
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              colors: [
                Color(0xFF3e1e52),
                Color(0xFF94259e),
              ],
            ),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Transform.translate(
                  offset: Offset(0, -10),
                  child: InkWell(
                    onTap: onPlusTap,
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.all(2),
                      width: ParamsAxis(context).width * 0.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xfff3dcf5),
                            Color(0xff9d24a5),
                          ],
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xFF3e1e52),
                              Color(0xFF94259e),
                            ],
                          ),
                        ),
                        child: Image.asset(
                          'assets/images/slots/plus.png',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Transform.translate(
                  offset: const Offset(0, 10),
                  child: InkWell(
                    onTap: onMinusTap,
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.all(2),
                      width: ParamsAxis(context).width * 0.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xfff3dcf5),
                            Color(0xff9d24a5),
                          ],
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xFF3e1e52),
                              Color(0xFF94259e),
                            ],
                          ),
                        ),
                        child: Image.asset(
                          'assets/images/slots/minus.png',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
