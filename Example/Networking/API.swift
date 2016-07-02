//
//  API.swift
//  RxDelegateCells
//
//  Created by Suyeol Jeon on 6/30/16.
//  Copyright © 2016 Suyeol Jeon. All rights reserved.
//

import RxSwift

struct API {

    func fetchNotificationList() -> Observable<[Notification]> {
        return Observable.deferred {
            let count = random() % 10 + 10
            let notifications = (0..<count).map { _ in self.randomNotification() }
            return Observable.just(notifications)
        }
    }

    private func randomNotification() -> Notification {
        return Notification(message: self.randomMessage())
    }

    private func randomMessage() -> NSAttributedString {
        let formats = [
            "{user} likes your post: \"{text}\"",
            "{user} likes your photo: \"{text}\"",
            "{user} likes your video: \"{text}\"",
            "{user} likes your comment: \"{text}\"",

            "{user} commented your post: \"{text}\"",
            "{user} commented your photo: \"{text}\"",
            "{user} commented your video: \"{text}\"",
            "{user} commented your comment: \"{text}\"",
        ]
        let users = [
            "Black Panther",
            "Black Widow",
            "Captain America",
            "Captain Marvel",
            "Falcon",
            "Hank Pym",
            "Hawkeye",
            "Hulk",
            "Iron Man",
            "Luke Cage",
            "Quicksilver",
            "Scarlet Witch",
            "Spider-Woman",
            "Thor",
            "Vision",
            "Wasp",
            "Wonder Man",
        ]
        let texts = [
            "JUST ANNOUNCED: We teamed up with @InsomniacGames for the new #SpiderManPS4 game! Read: http://bit.ly/25U91iy https://amp.twimg.com/v/b33b5aa1-6a0c-4f02-a129-713fc3970ae8 …",
            "Recap Black Panther #2 w/ @tanehisicoates in \"A Nation Under Our Feet\" ft music by @PRODIGYMOBBDEEP & @mvrkthebeast!https://amp.twimg.com/v/f1fdeac4-2510-4862-9fa5-dcd9989e4d0b …",
            "#StarkWeek rolls on with part three of our \"All Versions of Iron Man\" mini series! Tune in for part four tomorrow.https://amp.twimg.com/v/0bfe6d2f-05d3-4a7b-bc54-22b98189abc7 …",
            "Bucky battles a familiar foe and flashes back to his days with the Young Allies: http://bit.ly/293lpqT  #Cap75pic.twitter.com/GapksjmaJC",
            "Follow the story of Jedi Kerra Holt in #StarWars: Knight Errant! http://bit.ly/293hYQM pic.twitter.com/EoYaWINNMQ",
            "#StarkWeek continues with a look back at the classic #IronMan tale Demon in a Bottle! http://bit.ly/29cYDcy pic.twitter.com/fJvKHefQB3",
            "See which way @BRIANMBENDIS plans to steer Miles Morales in #CivilWarII: http://bit.ly/2930Bzp pic.twitter.com/gKJgrzCVuz",
            "Peggy Carter takes a turn as #CaptainAmerica in @MarvelPuzzle: http://marvel.com/news/video_games/26352/piecing_together_marvel_puzzle_quest_peggy_carter … #Cap75pic.twitter.com/wT9IHPAVLk",
            "#Marvel's #AgentsofSHIELD sets its Season 4 premiere date! http://bit.ly/292H2Yc pic.twitter.com/p4LtzjVqdi",
            "PREMIERE: @PRODIGYMOBBDEEP and @mvrkthebeast showcase the \"Beast\" in  'Black Panther' http://trib.al/jtQCQoV pic.twitter.com/CCrzpHPTPR",
            "Attention, class! Learn all about the hero Hyperion on a brand new episode of #Marvel101!https://amp.twimg.com/v/4ef9b92e-e93a-4fcd-9e8f-4568ca31938f …",
            "EXCLUSIVE.: Major #CaptainAmerica #HYDRA Revelations In 'Captain America: Steve Rogers' #2 http://bit.ly/29kwEGK pic.twitter.com/cBiAeRPVjS",
            "Enchantress, Falcon, and more join @CollectDST's Marvel Minimates line! Check it out: http://bit.ly/29bYW7w pic.twitter.com/dYg60s64bm",
            ".@JessicaJones composer Sean Callery talks about the soundtrack & more on #ThisWeekInMarvel! http://bit.ly/29bUlCs pic.twitter.com/DGOhYtRj1m",
            "Justin Trudeau joins Canadian superheroes as Marvel Comics cover star http://bit.ly/290IQwA  #cdnpolipic.twitter.com/lAq67TPlpa",
            "Continue #StarkWeek w/ a new episode of our \"All Versions of Iron Man\" mini series! Look for episode three tomorrow.https://amp.twimg.com/v/f69b0670-7c9d-4709-9f6a-b02f650621b5 …",
            "All week long, celebrate #Cap75 with @Marvel Games: http://marvel.com/news/video_games/26348/marvel_games_celebrate_captain_americas_75th_anniverary …pic.twitter.com/aRS7tM0WhZ",
            "#MarvelNOW! Fall 2016.pic.twitter.com/vOoFY6qJx3",
            "Steve Rogers abandons his post and becomes The Captain in another classic tale: http://bit.ly/2900zID  #Cap75pic.twitter.com/bHU06WwGQx",
            "Celebrate #StarkWeek with a look back at #IronMan’s first comic book appearance!pic.twitter.com/ZPDv1t3Xor",
            "#BlackPanther fights in the #Avengers-Defenders War, plus much more as his history rolls on! http://bit.ly/2993ZWl pic.twitter.com/qfZt09JrVT",
            "#CaptainAmerica's Peggy Carter wields the shield in the new #Marvel Game: http://share.ew.com/fcOYgKH pic.twitter.com/FBJtRVhmOe",
            "Gorgon of the Inhumans enters our Psych Ward—whether he likes it or not: http://bit.ly/298L7H3 pic.twitter.com/INEPJ6vuwK",
            "Jump into the world of \"Marvel's @JessicaJones\" with these new Minimates from @CollectDST! http://bit.ly/298F9pI pic.twitter.com/FVSaKLGK3f",
            "#SpiderMan! Hail Hydra! #StarkWeek! It's time for your #MarvelMinute with host @lorrainecink.https://amp.twimg.com/v/a44a103c-c523-43e3-a64f-9eec25126bcf …",
            "It's #StarkWeek & we're kicking it off w/ the \"All Versions of Iron Man\" series! Tune in each day for a new episode.https://amp.twimg.com/v/aeaa0154-ccaf-4ba6-8e1e-3d4f21a3fdcc …",
            "ICYMI: Listen to the  #ThisWeekInMarvel podcast ft. @gregpak, #XMen for #TWIMURC, & more!  http://bit.ly/292Q6c7 pic.twitter.com/wHDcUbcEni",
            "ICYMI: Guest @nick_lowe_ joins @lorrainecink, while @AgentM skateboards at the #XGames on #MarvelTHWIP! Watch:http://bit.ly/28O0CDR ",
            "ICYMI: Watch @BillRosemann's #WWDC2016 talk, “Marvel: Making a Difference in the Real World” http://bit.ly/28ONBgH pic.twitter.com/0h1H3gorGC",
            "ICYMI: Meet Mosaic, Marvel’s newest super hero! http://bit.ly/28NHE0a pic.twitter.com/JmmZkFEptI",
            " Cover Art of the Week: “DEADPOOL V GAMBIT” #1 (2016) by Kevin Wada & colors by Cris Peters!https://tmblr.co/ZuE4Iv28PZRKk ",
            "Thanks for stopping by Marvel HQ again, @BradPaisley. Catch him on tour this summer!pic.twitter.com/P0mK6qdZYp",
            "#CaptainAmerica clashes with the Secret Empire in this classic tale: http://bit.ly/28UAniz  #Cap75pic.twitter.com/QhNFTvNpCX",
            "Start your weekend with a new #ThisWeekInMarvel ft. @gregpak, classic #XMen, & more! Listen: http://bit.ly/292MR4y pic.twitter.com/HusT7mynky",
            "Hello there, Captain! #MarvelFanOfTheWeekhttps://twitter.com/Anaria32/status/745712434967543808 …",
            "Allister should be the #MarvelFanOfTheWeek because he is Captain America He has given his family avengers roles too pic.twitter.com/6T8Fm1AJqL",
            "#MarvelNOW! Fall 2016.pic.twitter.com/Qk0f8hAqL4",
            "Artist Ig Guara draws Laura and Old Man Logan into All-New Wolverine for #CivilWarII! http://bit.ly/292Hz94 pic.twitter.com/F9Cu3XxjdB",
            "We visited @vinniesbrooklyn earlier for an upcoming video series. Thanks for the hospitality...and all that pizza!pic.twitter.com/dh06iYuR2Z",
            "Creative Director @BillRosemann tells all about the latest #SpiderManPS4 news from E3! http://bit.ly/28U1lqO pic.twitter.com/Q0lYIWZmFS",
            "We rank the best Hulks on a new episode of #MarvelTopTen! Which characters would make your list?https://amp.twimg.com/v/d159737d-fb2c-4bfe-91df-943b914640fa …",
            "Even super heroes need some back up. Pick your side & shop #CaptainAmerica shoes at @Kohls! http://bit.ly/captamericashoes …pic.twitter.com/PdMap4kBdW",
        ]

        let format = self.choice(formats)
        let user = self.choice(users)
        let text = self.choice(texts)

        let messageAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(14)]
        let userAttributes = [NSFontAttributeName: UIFont.boldSystemFontOfSize(14)]
        let textAttributes = [NSFontAttributeName: UIFont.italicSystemFontOfSize(14)]

        let attributedUser = NSAttributedString(string: user, attributes: userAttributes)
        let attributedText = NSAttributedString(string: text, attributes: textAttributes)

        let attributedMessage = NSMutableAttributedString(string: format, attributes: messageAttributes)
        attributedMessage.replaceString("{user}", withAttributedString: attributedUser)
        attributedMessage.replaceString("{text}", withAttributedString: attributedText)
        return attributedMessage
    }

    private func choice<C: CollectionType where C.Index == Int>(collection: C) -> C.Generator.Element {
        return collection[random() % collection.count]
    }

}

private extension NSMutableAttributedString {

    func replaceString(string: String, withAttributedString attributedString: NSAttributedString) {
        let range = (self.string as NSString).rangeOfString(string)
        guard range.location != NSNotFound else { return }
        self.replaceCharactersInRange(range, withAttributedString: attributedString)
    }

}
