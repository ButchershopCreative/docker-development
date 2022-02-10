<?php

namespace Database\Seeders;

use Daynnnnn\StatamicDatabase;
use Illuminate\Database\Seeder;

class PagesCollectionSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $collectionModel = new StatamicDatabase\Entries\CollectionModel([
            'handle' => 'pages',
            'data' => ([
                'title' => 'Pages',
                'template' => 'default',
                'layout' => 'layout',
                'revisions' => false,
                'route' => '{slug}',
                'sort_dir' => 'asc',
                'date_behavior' => ([
                    'past' => 'public',
                    'future' => 'private',
                ]),
                'inject' => 'null',
                'structure' => ([
                    'root' => true,
                ]),
            ])
        ]);
        $collectionModel->save();

        $entryModel = new StatamicDatabase\Entries\EntryModel([
            'site' => 'default',
            'published' => 1,
            'status' => 'published',
            'slug' => 'home',
            'uri' => '/',
            'collection' => 'pages',
            'data' => ([
                'title' => 'Home',
                'content' => 'Welcome!',
                'author' => null,
                'template' => 'home',
                'parent' => null,
                'updated_by' => null
            ])
        ]);
        $entryModel->save();

        $treeModel = new StatamicDatabase\Trees\TreeModel([
            'handle' => 'collection::pages::default',
            'data' => ([
                'tree' => ([
                    ([
                        'entry' => $entryModel->id
                    ])
                ])
            ])
        ]);
        $treeModel->save();
    }
}
