import 'package:flutter_test/flutter_test.dart';
import 'package:kart_motoru/kart_motoru.dart';
import 'package:oyun_cincon/oyun_cincon.dart';
import 'package:studio_core/core/level_plan.dart';

void main() {
  test('33 dilde ad ve anlatım', () {
    expect(cinconConfig.title.length, 33);
    expect(cinconConfig.tagline.length, 33);
    for (final s in cinconConfig.tutorial) {
      expect(s.text.length, 33);
    }
    expect(cinconConfig.gameId, cinconId);
    expect(cinconRules.gameId, cinconId);
    expect(cinconRules.levelCount, 100000);
  });

  test('bölümler kazanılabilir ve oyun sonuna kadar oynanır', () {
    expect(cinconRules.localPlayers, 2);
    final planner = LevelPlanner(gameId: cinconId, optionalMechanics: const []);
    for (final lv in [1, 77, 1500, 33333, 99999]) {
      final gl = cinconRules.build(planner.spec(lv));
      expect(gl.validation.ok, isTrue, reason: 'bölüm $lv');
      final end = TableGameRules.simulate(gl.puzzle, quick: true);
      expect(end.over, isTrue, reason: 'bölüm $lv');
    }
  }, timeout: const Timeout(Duration(minutes: 8)));
}
