import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class ArticlesData {
  final String image;
  final String name;
  final int reward;
  final String mainImage;
  final String mainText;

  ArticlesData({
    required this.image,
    required this.name,
    required this.reward,
    required this.mainImage,
    required this.mainText,
  });
}

List<ArticlesData> articlesData = [
  ArticlesData(
      image: '1.png',
      mainImage: '1x.png',
      mainText:
          'Payout percentages on slot machines can vary widely depending on the type of machine, the casino, and the specific game. Casinos typically don\'t publish detailed information on the payout percentages of individual machines, but they do provide general information about the overall payout percentages for categories of games. Keep in mind that payout percentages are determined over the long term and may not be indicative of short-term results. Additionally, slot machines use random number generators (RNGs), making it impossible to predict or manipulate outcomes.',
      name: 'Payout percentages on slot\nmachines',
      reward: 200),
  ArticlesData(
    image: '2.png',
    mainImage: '2x.png',
    mainText:
        'Casino games are games of chance and skill that are typically played in casinos or online gambling platforms for the opportunity to win money or other prizes.\n1. Slot Machines: Slot machines are the most iconic casino games. Players insert coins or credits and spin the reels, hoping to match symbols and win prizes. These games are entirely based on luck. \n 2.Roulette: A game where players bet on the outcome of a spinning wheel, with various betting options. \n 3. Pookies. A classic slot machine with 5 figures in a row.',
    name: 'What are casino games?',
    reward: 200,
  ),
  ArticlesData(
    image: '3.png',
    mainImage: '3x.png',
    mainText:
        '1.Random Number Generator (RNG): Modern pokies operate using a computer program called a Random Number Generator (RNG). \n2.Symbols and Reels: our Pokies have five reels, each with various symbols. When you spin the reels, the RNG generates a random combination of symbols on each reel.\n3.Paylines: Pokies have multiple paylines, which are the lines where winning combinations of symbols must appear. Traditional pokies have a single payline across the center, while video pokies can have multiple paylines in various patterns.',
    name: 'How pokies work',
    reward: 200,
  ),
  ArticlesData(
    image: '4.png',
    mainImage: '4x.png',
    mainText:
        'There are symbols betting options in roulette. The roulette measure is divided into light and dark parts.He determines the winnings. Several identical values in a row give a bonus.',
    name: 'Casino roulette guide',
    reward: 200,
  ),
  ArticlesData(
    image: '5.png',
    mainImage: '5x.png',
    mainText:
        'Slot machines with fixed jackpots offer consistent and predictable payouts. The jackpot amount remains the same, and it doesn\'t increase or decrease based on the number of players or the duration of play.\nFixed jackpot machines often have better odds of winning smaller prizes compared to progressive jackpot machines. While the payouts may not be as massive, you have a higher likelihood of hitting smaller wins more frequently. If you prefer a steady and more prolonged gaming experience, fixed jackpot machines are a good choice. You can enjoy playing longer without the urgency of chasing a growing progressive jackpot.',
    name: 'Machines with fixed jackpots',
    reward: 200,
  ),
  ArticlesData(
    image: '6.png',
    mainImage: '6x.png',
    mainText:
        'The most significant advantage of progressive jackpot machines is the potential for life-changing wins. Progressive jackpots can grow to substantial amounts, often reaching millions of dollars. This massive payout potential is a major draw for players.While the major jackpot is a rare occurrence, progressive slot machines often offer smaller, more frequent wins to keep players engaged. These wins can help sustain the gaming experience even if the jackpot remains elusive.',
    name: 'Machines with progressive\njackpots',
    reward: 200,
  ),
  ArticlesData(
    image: '7.png',
    mainImage: '7x.png',
    mainText:
        'Payout percentages on slot machines can vary widely depending on the type of machine, the casino, and the specific game. Casinos typically don\'t publish detailed information on the payout percentages of individual machines, but they do provide general information about the overall payout percentages for categories of games. Keep in mind that payout percentages are determined over the long term and may not be indicative of short-term results. Additionally, slot machines use random number generators (RNGs), making it impossible to predict or manipulate outcomes.',
    name: 'Free tables',
    reward: 200,
  ),
  ArticlesData(
    image: '8.png',
    mainImage: '8x.png',
    mainText:
        'Playing in a high-traffic area can enhance your gaming experience, especially if you enjoy the social aspect of casino gaming. However, it\'s important to remember that more players can also mean more competition and potentially longer waiting times for certain games. Additionally, high-traffic games might have higher stakes.',
    name: 'High-traffic area',
    reward: 200,
  ),
];

Widget articleItem(
    BuildContext context, String image, String title, int reward) {
  return Container(
    height: 50,
    width: 355,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color.fromARGB(159, 29, 11, 35),
          Color.fromARGB(149, 135, 33, 142)
        ],
      ),
    ),
    child: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset('assets/images/articles/$image'),
            ),
          ),
          const SizedBox(
            width: 3,
          ),
          Text(
            title,
            maxLines: 2,
            style: GoogleFonts.bebasNeue(
              color: const Color.fromARGB(212, 209, 119, 215),
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
          const Spacer(),
          Container(
            height: 50,
            width: 81,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(45),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(45),
              child: Image.asset('assets/images/articles/reward.png'),
            ),
          ),
          const SizedBox(
            width: 2,
          ),
        ],
      ),
    ),
  );
}
